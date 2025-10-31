default:
    @just --list

[group("Canvas")]
[doc("Render all markdown files under canvas/ to rich text (html fragments). And outputs them under the out directory")]
render-canvas-pages:
    #!/usr/bin/env bash
    OUT_DIR="out/canvas-pages"
    PANDOC_FLAGS="--from markdown --to html"

    mkdir -p ${OUT_DIR} # Make sure the output directory exists

    echo "Running pandoc transform on all markdown files under canvas/..."
    find . -type f -path "*/canvas/*.md" | while read -r file; do
        # Extract potential name from frontmatter
        name="$(awk '/^---/{f=!f;next} f && /^tittel:/{sub(/^tittel:[[:space:]]*/, ""); gsub(/"/, ""); print; exit}' "$file")"

        # Fallback to basename if not found
        if [[ -z "$name" ]]; then
            name="$(basename "$file" .md)"
        fi

        out="${OUT_DIR}/${name}.html";
        echo "→ ${file} → ${out}";
        pandoc "${file}" -o "${out}" ${PANDOC_FLAGS};
    done

    echo "Running prettier on all html files under ${OUT_DIR}..."
    prettier --write ${OUT_DIR}/**/*.html
