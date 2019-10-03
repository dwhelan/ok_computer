defmodule OkComputer.OkTuple do
  alias OkComputer.Monad.{OkTuple, ErrorTuple}

  import OkComputer.Switch

  switch(OkTuple, ErrorTuple)
end
