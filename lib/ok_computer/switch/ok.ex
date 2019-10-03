defmodule OkComputer.Switch.Ok do
  alias OkComputer.Monad.{Ok, Error}

  import OkComputer.Switch

  switch(Ok, Error)
end
