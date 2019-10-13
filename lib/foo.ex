defmodule Foo2 do
  import OkComputer.Operator

#  defoperators Foo, +: fn lhs, rhs -> "#{lhs} <> #{rhs}" end
#  IO.inspect foo: Foo.module_info
end
