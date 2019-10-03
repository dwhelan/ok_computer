defmodule OkComputer.Ok do
  alias OkComputer.Monad.{Ok, ErrorTuple}

  import OkComputer.Switch

  switch(Ok, ErrorTuple)
end
