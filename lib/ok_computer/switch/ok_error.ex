defmodule OkComputer.Switch.OkError do
  @moduledoc """
g
  """
  alias OkComputer.Monad.{Ok, Error}

  import OkComputer.Pipe

  pipes Ok, fmap: :~>,  bind: :~>>
  pipes Error, fmap: :<~,  bind: :<<~
end
