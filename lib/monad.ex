defmodule Monad do
  @type monad :: any
  @type t :: monad

  @callback return(any) :: monad
  @callback bind(t, (any -> monad)) :: monad
end
