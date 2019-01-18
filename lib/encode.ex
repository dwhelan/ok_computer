defmodule Result do

  def ok(ok={_, bytes, codec}) when is_binary(bytes) and is_atom(codec), do: OkError.ok(ok)
end

defmodule Encode do
  @behaviour Monad

  @type codec :: module
  @type ok_encode :: {:ok, {any, binary, codec}}
  @type error_encode :: {:error, any}

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return({:ok, result}),    do: Result.ok result
  def return({:error, reason}), do: {:error, reason}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, result}, map) when is_function(map) do
    case map.(result) do
      {:ok, {value, _, codec}} -> apply codec, :encode, [value]
      error -> error
    end
  end

  def bind({:error, reason}, map) when is_function(map) do
    {:error, reason}
  end

  def ok({value, bytes, codec}) when is_binary(bytes) and is_atom(codec) do
    {:ok, {value, bytes, codec}}
  end
end
