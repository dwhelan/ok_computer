[
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  locals_without_parens: [
    operators: :*,
    defoperator_macros: :*,
    pipe: :*,
    pipes: :*
  ]
]
