;; extends

; GoLand colours the receiver of a method declaration (GO_METHOD_RECEIVER).
; Usages inside the body are plain identifiers and cannot be told apart here.
(method_declaration
  receiver: (parameter_list
    (parameter_declaration
      name: (identifier) @variable.parameter.receiver)))

; Darcula draws commas and semicolons in keyword orange (DEFAULT_COMMA,
; DEFAULT_SEMICOLON) while dots and brackets stay plain.
"," @punctuation.delimiter.comma
";" @punctuation.delimiter.comma
