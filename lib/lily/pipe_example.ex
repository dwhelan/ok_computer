# defmodule Lily.PipeExample do
#  import Lily.Operator
#
#  operator_macro :~>, fn left, right ->
#    quote do
#      "#{unquote left} ringy dingies" |> unquote(right)
#    end
#  end
# end
#
# defmodule Lile.PipeUser do
#  import Lily.PipeExample
#
#  1 ~> IO.inspect
# end
