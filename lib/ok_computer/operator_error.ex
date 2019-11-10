defmodule OkComputer.OperatorError do
  defexception [:message]

  @impl true
  def exception(value) do
    msg = ~s/cannot create an operator for "#{value}", because it is used by the Elixir parser./
    %OkComputer.OperatorError{message: msg}
  end
end
