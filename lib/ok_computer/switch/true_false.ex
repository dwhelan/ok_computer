defmodule OkComputer.Switch.TrueFalse do
  alias OkComputer.Pipe.{True, False}

  import OkComputer.Pipe

  pipe(True)
  #  pipe False, fmap: :<~, bind: :<<~
end
