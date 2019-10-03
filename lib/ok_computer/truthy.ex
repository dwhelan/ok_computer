defmodule OkComputer.Truthy do
  alias OkComputer.Monad.{Truthy, False}

  import OkComputer.Switch

  switch(Truthy, False)
end
