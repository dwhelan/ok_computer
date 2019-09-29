defmodule OkComputer.Truthy do
  import OkComputer.Switch
  alias OkComputer.Monads.{Truthy, Falsey}

  monadic_switch Truthy, Falsey
end
