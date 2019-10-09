defmodule OkComputer.Switch.OkError do
  @moduledoc """

  ```
  pipe Ok:    [~>: :fmap, ~>>: :bind],
       Error: [<~: :fmap, <<~: :bind]

  pipe Ok:    [fmap: :~>, bind: :~>>],
       Error: [fmap: :<~, bind: :<<~]
  ```
  """
  alias OkComputer.Monad.{Ok, Error}

  import OkComputer.Pipe

  build Ok, :fmap, :~>
  build  Ok, :bind, :~>>
end
