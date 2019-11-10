defmodule OkComputer.OperatorError do
  defexception [:message]

  @impl true
  def exception(atom) do
    message =
      ~s/cannot create an operator for "#{atom}", because it is used by the Elixir parser./

    %OkComputer.OperatorError{message: message}
  end
end
