; inherits: jinja

; {{ }} and {% %} delimiters (colored in colorschemes/tokyonight.lua)
([
  "{{"
  "{{-"
  "{{+"
  "}}"
  "-}}"
  "+}}"
  "{%"
  "{%-"
  "{%+"
  "%}"
  "-%}"
  "+%}"
] @punctuation.special.braces
  ; beat the injected sql string highlight in e.g. '{{ var("x") }}'
  (#set! priority 110))

; dbt jinja context: https://docs.getdbt.com/reference/dbt-jinja-functions
(function_call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    "ref" "source" "config" "var" "env_var" "is_incremental" "run_query" "log"
    "return" "statement" "load_result" "doc" "exceptions" "fromjson" "tojson"
    "fromyaml" "toyaml" "zip" "set" "print" "dispatch"))

((identifier) @variable.builtin
  (#any-of? @variable.builtin
    "this" "target" "adapter" "model" "graph" "invocation_id" "modules" "builtins"
    "execute" "flags" "project_name" "run_started_at" "schemas" "selected_resources"))
