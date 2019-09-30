defmodule OkComputer.Truthy do
  alias OkComputer.Monad.{Truthy, Falsey}

  import OkComputer.Switch

  switch(Truthy, Falsey)
end
