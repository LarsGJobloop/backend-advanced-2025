default:
    @just --list

[group("Canvas")]
[doc("Scans canvas markdown files and writes out metadata manifest.")]
generate-canvas-manifest:
    #!/usr/bin/env bash
    OUT_DIR="out/canvas-pages"
    META_FILE="${OUT_DIR}/manifest.json"
    mkdir -p "${OUT_DIR}"

    tmpfile=$(mktemp)
    echo "Generating manifest..."

    find . -type f -path "*/canvas/*.md" | while read -r file; do
        title="$(awk '/^---/{f=!f;next} f && /^tittel:/{sub(/^tittel:[[:space:]]*/, ""); gsub(/"/, ""); print; exit}' "$file")"
        slug="$(awk '/^---/{f=!f;next} f && /^slug:/{sub(/^slug:[[:space:]]*/, ""); gsub(/"/, ""); print; exit}' "$file")"
        out="${OUT_DIR}/${slug}.html"

        jq -nc \
            --arg file "$file" \
            --arg title "$title" \
            --arg slug "$slug" \
            --arg out "$out" \
            '{file: $file, title: $title, slug: $slug, out: $out}' >> "$tmpfile"
    done

    jq -s '.' "$tmpfile" > "$META_FILE"
    rm "$tmpfile"
    echo "Manifest written to ${META_FILE}"

[private]
_for_each_canvas_page:
    #!/usr/bin/env bash
    META_FILE="out/canvas-pages/manifest.json"
    if [ ! -f "$META_FILE" ]; then
        echo "Manifest not found. Run: just generate-canvas-manifest"
        exit 1
    fi
    jq -c '.[]' "$META_FILE"

[group("Canvas")]
[doc("Renders source files to rich text (html fragments).")]
render-canvas-pages: generate-canvas-manifest
    #!/usr/bin/env bash
    OUT_DIR="out/canvas-pages"
    PANDOC_FLAGS="--from markdown --to html"
    mkdir -p "${OUT_DIR}"

    just _for_each_canvas_page | while read -r page; do
        file=$(echo "$page" | jq -r '.file')
        out=$(echo "$page" | jq -r '.out')
        slug=$(echo "$page" | jq -r '.slug')

        echo "Rendering ${file} → ${out}"
        pandoc "$file" -o "$out" ${PANDOC_FLAGS}
    done

    prettier --write "${OUT_DIR}/**/*.html"

[group("Canvas")]
[doc("Upload html file under out/canvas-pages to Canvas.")]
upload-canvas-pages: generate-canvas-manifest
    #!/usr/bin/env bash
    just _for_each_canvas_page | while read -r page; do
        slug=$(echo "$page" | jq -r '.slug')
        title=$(echo "$page" | jq -r '.title')
        out=$(echo "$page" | jq -r '.out')

        echo "Uploading ${slug}..."
        just _upload_page "$slug" "$title" "$out" || {
            echo "Failed to upload ${slug}" >&2
        }
        sleep 1
    done

[private]
_upload_page slug title path:
    #!/usr/bin/env bash
    CANVAS_ACCESS_TOKEN=$(sops exec-env secrets.yaml 'bash -c "echo $canvas_access_token"')
    CANVAS_DOMAIN="https://jobloop.instructure.com"
    CANVAS_COURSE_ID="515"

    # Lookup page url from slug-id-mapping.json using title as key
    CANVAS_URL=$(jq -r ".[\"{{ title }}\"]" "out/canvas-pages/slug-id-mapping.json" 2>/dev/null || echo "null")
    
    if [ "${CANVAS_URL}" != "null" ]; then
        # DEBUG
        echo "Updating page: ${CANVAS_DOMAIN}/api/v1/courses/${CANVAS_COURSE_ID}/pages/${CANVAS_URL}"
        
        # Page exists - update via PUT
        curl -sS -o /dev/null -w "{{ slug }} → HTTP %{http_code}\n" \
            -X PUT \
            -H "Authorization: Bearer ${CANVAS_ACCESS_TOKEN}" \
            --data-urlencode "wiki_page[title]={{ title }}" \
            --data-urlencode "wiki_page[body]@-" \
            "${CANVAS_DOMAIN}/api/v1/courses/${CANVAS_COURSE_ID}/pages/${CANVAS_URL}" < "{{ path }}"
    else
        # DEBUG
        echo "Creating page: ${CANVAS_DOMAIN}/api/v1/courses/${CANVAS_COURSE_ID}/pages"

        # Page doesn't exist - create via POST
        curl -sS -o /dev/null -w "{{ slug }} → HTTP %{http_code}\n" \
            -X POST \
            -H "Authorization: Bearer ${CANVAS_ACCESS_TOKEN}" \
            --data-urlencode "wiki_page[title]={{ title }}" \
            --data-urlencode "wiki_page[url]={{ slug }}" \
            --data-urlencode "wiki_page[body]@-" \
            "${CANVAS_DOMAIN}/api/v1/courses/${CANVAS_COURSE_ID}/pages" < "{{ path }}"
    fi

[group("Canvas")]
[doc("Update the slug-id mapping file.")]
update-canvas-page-mapping:
    #!/usr/bin/env bash
    PER_PAGE=50

    CANVAS_ACCESS_TOKEN=$(sops exec-env secrets.yaml 'bash -c "echo $canvas_access_token"')
    CANVAS_DOMAIN="https://jobloop.instructure.com"
    COURSE_ID="515"

    OUT_DIR="out/canvas-pages"
    MAPPING_FILE="${OUT_DIR}/slug-id-mapping.json"
    mkdir -p "${OUT_DIR}"

    # Canvas is based on Ruby on Rails, which transmits pagination information in the headers.
    # It's a remnant of the old days where Transport and Application semantics blurred.
    # Map titles to URLs for lookup
    curl -sS \
        -H "Authorization: Bearer ${CANVAS_ACCESS_TOKEN}" \
        "${CANVAS_DOMAIN}/api/v1/courses/${COURSE_ID}/pages?per_page=${PER_PAGE}" | \
        jq 'map({(.title): .url}) | add' > "${MAPPING_FILE}"
