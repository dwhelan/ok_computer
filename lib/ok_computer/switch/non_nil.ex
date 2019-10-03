defmodule OkComputer.NonNil do
  alias OkComputer.Monad.{NonNil, Nil}

  import OkComputer.Switch

  switch(NonNil, Nil)
end
