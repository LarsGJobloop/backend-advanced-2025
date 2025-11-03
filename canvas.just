# Canvas API module
# Provides recipes for interacting with Canvas LMS REST API

CANVAS_DOMAIN := "https://jobloop.instructure.com"
CANVAS_ACCESS_TOKEN := `sops exec-env secrets.yaml 'bash -c "echo $canvas_access_token"'`

[doc("Creates a new page in Canvas.")]
create-page slug title body_path course_id:
    #!/usr/bin/env bash
    curl -sS -o /dev/null -w "{{ slug }} → HTTP %{http_code}\n" \
        -X POST \
        -H "Authorization: Bearer {{ CANVAS_ACCESS_TOKEN }}" \
        --data-urlencode "wiki_page[title]={{ title }}" \
        --data-urlencode "wiki_page[url]={{ slug }}" \
        --data-urlencode "wiki_page[body]@-" \
        "{{ CANVAS_DOMAIN }}/api/v1/courses/{{ course_id }}/pages" < "{{ body_path }}"

[doc("Updates an existing page in Canvas.")]
update-page url title body_path course_id:
    #!/usr/bin/env bash    
    curl -sS -o /dev/null -w "{{ url }} → HTTP %{http_code}\n" \
        -X PUT \
        -H "Authorization: Bearer {{ CANVAS_ACCESS_TOKEN }}" \
        --data-urlencode "wiki_page[title]={{ title }}" \
        --data-urlencode "wiki_page[body]@-" \
        "{{ CANVAS_DOMAIN }}/api/v1/courses/{{ course_id }}/pages/{{ url }}" < "{{ body_path }}"

[doc("Lists pages in a Canvas course.")]
list-pages course_id per_page="50" search_term="":
    #!/usr/bin/env bash
    SEARCH_TERM=$(echo "{{ search_term }}" | urlencode)

    curl -sS \
        -H "Authorization: Bearer {{ CANVAS_ACCESS_TOKEN }}" \
        "{{ CANVAS_DOMAIN }}/api/v1/courses/{{ course_id }}/pages?per_page={{ per_page }}&search_term=${SEARCH_TERM}"

[doc("Gets a single page from Canvas by URL.")]
get-page course_id url:
    #!/usr/bin/env bash
    curl -sS \
        -H "Authorization: Bearer {{ CANVAS_ACCESS_TOKEN }}" \
        "{{ CANVAS_DOMAIN }}/api/v1/courses/{{ course_id }}/pages/{{ url }}"
