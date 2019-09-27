defmodule Monad do
  @type monad :: any

  @callback return(any) :: monad
  @callback bind(monad, (any -> monad)) :: monad

  defmodule Operators do
    defmacro a ~> f  do
      pipe_bind a, f
    end

    defp pipe_bind(a, f = {atom, _, _}) when atom in [:fn, :&] do
      quote location: :keep do
        unquote(a)
        |> return
        |> bind(unquote f)
        |> return
      end
    end

    defp pipe_bind a, f do
      quote location: :keep do
        unquote(a)
        |> return
        |> bind(&unquote(f)/1)
        |> return
      end
    end
  end
end
