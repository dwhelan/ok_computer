[
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  locals_without_parens: [
    operators: :*,
    operator_macro: :*,
    pipe: :*,
    pipes: :*
  ]
]
