; [
;   "{{"
;   "{{-"
;   "{{+"
;   "+}}"
;   "-}}"
;   "}}"
;   "{%"
;   "{%-"
;   "{%+"
;   "+%}"
;   "-%}"
;   "%}"
; ] @keyword.directive
;
; ; TODO: only match raw
; (block_node) @keyword

;; Inject jinja inside YAML when jinja syntax is detected
; ((block_mapping_pair
;   key: (_) @jinja))
;
; ((block_mapping_pair
;   value: (_) @jinja))

; ((flow_node) @jinja
;   (#match? @jinja "{{.*}}"))
;
; ((flow_node) @jinja
;   (#match? @jinja "{%.*%}"))

; ((plain_scalar) @jinja
;   (#match? @jinja "{{.*}}"))
;
; ((plain_scalar) @jinja
;   (#match? @jinja "{%.*%}"))

;; TAKE 2

;; Inject Jinja2 when `{% ... %}` or `{{ ... }}` appear inside YAML
; (
;  (block_node) @jinja
;  (#match? @jinja "{[{%]-.*-[}%}]}")
; )

;; TAKE 3

;; Inject Jinja2 when `{% ... %}` or `{{ ... }}` appear inside YAML
; (
;   (block_mapping_pair
;     key: (_) @jinja
;   )
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )
;
; (
;   (block_mapping_pair
;     value: (_) @jinja
;   )
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )
;
; (
;   (block_node) @jinja
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )
;

; (
;   (block_mapping_pair) @jinja
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )
;
; (
;   (block_node) @jinja
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )
;
; (
;   (flow_node) @jinja
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )
;
; (
;   (plain_scalar) @jinja
;   (#match? @jinja ".*[{]{1,2}[%].*[%][}]{1,2}.*")
; )

(stream
  key: (document) @_expr
  (#match? @_expr ".*[{]{1,2}[%].*[%][}]{1,2}.*")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "jinja")))

(stream
  key: (document) @_expr
  (#match? @_expr ".*[{]{1,2}[%].*[%][}]{1,2}.*")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "jinja")
    (#offset! @injection.content 0 1 0 0)))

(stream
  key: (document) @_expr
  (#match? @_expr ".*[{]{1,2}[%].*[%][}]{1,2}.*")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "jinja")))))

(stream
  key: (document) @_expr
  (#match? @_expr ".*[{]{1,2}[%].*[%][}]{1,2}.*")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "jinja")
          (#offset! @injection.content 0 1 0 0))))))
