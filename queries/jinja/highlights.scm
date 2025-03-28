(
  (definition) @yaml
  (#match? @yaml ".*[{]{1,2}[%].*[%][}]{1,2}.*")
)
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
