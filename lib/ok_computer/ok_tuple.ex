defmodule OkComputer.OkTuple do
  alias OkComputer.Monad.{OkTuple, Falsey}

  import OkComputer.Switch

  switch(OkTuple, Falsey)
end
