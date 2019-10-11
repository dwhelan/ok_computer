defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Pipe.{Value, Nil}

  import OkComputer.Pipe

  pipe Nil, Value
  #  pipe Nil, fmap: :<~, bind: :<<~
end
