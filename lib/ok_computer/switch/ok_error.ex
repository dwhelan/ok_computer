defmodule OkComputer.Switch.OkError do
  alias OkComputer.Monad.{Ok, Error}

  import OkComputer.Pipe

  build :~>, Ok, :fmap
  build :~>>, Ok, :bind

#  build Ok: [~>: :fmap, ~>>: :bind]
end
