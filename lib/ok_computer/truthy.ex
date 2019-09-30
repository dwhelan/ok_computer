defmodule OkComputer.Truthy do
  alias OkComputer.Monad.{Truthy, Falsey}

  import OkComputer.Switch

  monadic_switch(Truthy, Falsey)
end
