; inherits: jinja

; the text between jinja tags is sql, parsed as one combined document
((content) @injection.content
  (#set! injection.language "sql")
  (#set! injection.combined))
