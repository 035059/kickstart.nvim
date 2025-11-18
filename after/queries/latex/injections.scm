;; Match text nodes that contain Python-like patterns
((text) @injection.content
  (#match? @injection.content "(print|import|def|class|for|while|if)[ (]")
  (#set! injection.language "python"))

;; Match text between \begin{pycode} and \end{pycode}
((text) @injection.content
  (#match? @injection.content "\\\\begin\\{py(code|verbatim|block)")
  (#set! injection.language "python"))
