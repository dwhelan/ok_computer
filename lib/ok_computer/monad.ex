defmodule OkComputer.Monad do
  @moduledoc """
  Describes monadic behaviour.
  """
  @type t :: any

  @doc "return"
  @callback return(any) :: t

  @doc "bind"
  @callback bind(t, (any -> t)) :: t

  @callback value_quoted(Macro.t) :: Macro.t
end
