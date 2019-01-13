ExUnit.start()

defmodule TestHelper do
  def assert_code_error code do
    ExUnit.Assertions.assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end
end
