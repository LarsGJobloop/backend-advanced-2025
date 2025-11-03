mod canvas

# The Canvas Course (Norsk Emne ID) to sync with.
CANVAS_COURSE_ID := "373"

# Filters for content to be synced to Canvas
# We are exceedingly cautious here as otherwise we might
# overwrite existing content.
# Loose filter for partial titles.
CONTENT_FILTER := "C# Advanced"
# Concrete filter for last updated by.
CONTENT_RESPONSIBLE := "Lars Gunnar"

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
[doc("Upload html file under out/canvas-pages to Canvas. Default is dry-run mode - pass 'apply' to make changes.")]
upload-canvas-pages apply="false": generate-canvas-manifest update-canvas-page-mapping
    #!/usr/bin/env bash
    MAPPING_FILE="out/canvas-pages/title-to-id-mapping.json"

    # Safety check: ensure mapping file exists and is non-empty
    if [ ! -f "$MAPPING_FILE" ] || [ ! -s "$MAPPING_FILE" ]; then
        echo "ERROR: Mapping file not found or empty. Run: just update-canvas-page-mapping" >&2
        exit 1
    fi

    if [ "{{ apply }}" != "true" ]; then
        echo "=== DRY-RUN MODE: No changes will be made ==="
        echo "=== Run with 'apply' argument to make actual changes ==="
    fi
    echo ""

    just _for_each_canvas_page | while read -r page; do
        slug=$(echo "$page" | jq -r '.slug')
        title=$(echo "$page" | jq -r '.title')
        out=$(echo "$page" | jq -r '.out')

        CANVAS_URL=$(jq -r ".[\"${title}\"]" "$MAPPING_FILE" 2>/dev/null || echo "null")

        if [ "${CANVAS_URL}" = "null" ] || [ -z "${CANVAS_URL}" ]; then
            echo "SKIP::(not in mapping)::${title}"
            continue
        fi

        # Verify ownership before updating
        PAGE_DATA=$(just canvas::get-page "{{ CANVAS_COURSE_ID }}" "${CANVAS_URL}" 2>/dev/null || echo "")

        if [ -z "$PAGE_DATA" ]; then
            echo "SKIP::(fetch failed)::${CANVAS_URL}"
            continue
        fi

        LAST_EDITED_BY=$(echo "$PAGE_DATA" | jq -r '.last_edited_by.display_name // ""')

        if [ "$LAST_EDITED_BY" != "{{ CONTENT_RESPONSIBLE }}" ]; then
            echo "SKIP::(edited by ${LAST_EDITED_BY})::${CANVAS_URL}"
            continue
        fi

        # Present page info
        echo "URL: ${CANVAS_URL}"
        echo "Title: ${title}"
        echo "Last edited by: ${LAST_EDITED_BY}"

        if [ "{{ apply }}" = "true" ]; then
            # Interactive confirmation
            while true; do
                read -p "Update this page? (y/n): " response < /dev/tty
                case "$response" in
                    yes|y)
                        just canvas::update-page "${CANVAS_URL}" "${title}" "${out}" "{{ CANVAS_COURSE_ID }}" || {
                            echo "Failed to update ${CANVAS_URL}" >&2
                        }
                        break
                        ;;
                    no|n)
                        echo "Skipped"
                        break
                        ;;
                    *)
                        echo "Answer 'y' or 'n'"
                        ;;
                esac
            done
        else
            # Dry-run: just show what would be updated
            echo "  [DRY-RUN: would update]"
        fi
        echo ""

        sleep 1
    done

[group("Canvas")]
[doc("Update the title-to-id mapping file.")]
update-canvas-page-mapping:
    #!/usr/bin/env bash
    PER_PAGE=50

    OUT_DIR="out/canvas-pages"
    MAPPING_FILE="${OUT_DIR}/title-to-id-mapping.json"
    mkdir -p "${OUT_DIR}"

    # Canvas is based on Ruby on Rails, which transmits pagination information in the headers.
    # It's a remnant of the old days where Transport and Application semantics blurred.
    # Filter to only pages last edited by CONTENT_RESPONSIBLE, then map titles to URLs for lookup.
    just canvas::list-pages "{{ CANVAS_COURSE_ID }}" "${PER_PAGE}" "{{ CONTENT_FILTER }}" | \
        jq --arg responsible "{{ CONTENT_RESPONSIBLE }}" 'map(select(.last_edited_by.display_name == $responsible)) | map({(.title): .url}) | add' > "${MAPPING_FILE}"

[group("Validation")]
[doc("Validate frontmatter structure in all canvas markdown files.")]
validate-frontmatter:
    #!/usr/bin/env bash
    set -euo pipefail
    
    tmpfile=$(mktemp)
    count=0
    
    echo "Validating frontmatter in canvas markdown files..."
    
    while IFS= read -r file; do
        count=$((count + 1))
        
        # Check if file starts with frontmatter delimiter
        if ! head -n 1 "$file" | grep -q "^---$"; then
            echo "ERROR: $file does not start with frontmatter delimiter (---)" >> "$tmpfile"
            continue
        fi
        
        # Extract frontmatter fields
        title="$(awk '/^---/{f=!f;next} f && /^tittel:/{sub(/^tittel:[[:space:]]*/, ""); gsub(/"/, ""); print; exit}' "$file" || true)"
        slug="$(awk '/^---/{f=!f;next} f && /^slug:/{sub(/^slug:[[:space:]]*/, ""); gsub(/"/, ""); print; exit}' "$file" || true)"
        
        # Validate required fields exist and are not empty
        if [ -z "$title" ]; then
            echo "ERROR: $file is missing required field 'tittel'" >> "$tmpfile"
        fi
        
        if [ -z "$slug" ]; then
            echo "ERROR: $file is missing required field 'slug'" >> "$tmpfile"
        fi
    done < <(find . -type f -path "*/canvas/*.md")
    
    if [ -s "$tmpfile" ]; then
        cat "$tmpfile" >&2
        rm "$tmpfile"
        echo "Validation failed" >&2
        exit 1
    fi
    
    rm "$tmpfile"
    echo "✓ Validated $count file(s) successfully"
