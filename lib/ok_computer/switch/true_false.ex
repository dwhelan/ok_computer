defmodule OkComputer.Switch.TrueFalse do
  alias OkComputer.Pipe.{True, False}

  import OkComputer.Pipe

  pipe True, fmap: :~>, bind: :~>>
  pipe False, fmap: :<~, bind: :<<~
end
