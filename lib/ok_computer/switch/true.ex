defmodule OkComputer.Switch.True do
  alias OkComputer.Monad.{True, False}

  import OkComputer.Switch

  switch(True, False)
end
