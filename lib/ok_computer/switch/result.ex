defmodule OkComputer.Switch.Result do
  @moduledoc """
  A switch for handling :ok, or :error tuple results.
  """
  alias OkComputer.Monad.{Ok, Error}
  import OkComputer.Pipe

  pipes Ok, fmap: :~>, bind: :~>>
  pipes Error, fmap: :<~, bind: :<<~
end
