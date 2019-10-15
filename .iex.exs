defmodule Steps do
  def stringify(input) do
    case input do
      {:ok, value} -> {:ok, to_string(value)}
      anything_else -> anything_else
    end
  end

  def upcase(input) do
    case input do
      {:ok, value} -> {:ok, String.upcase(value)}
      anything_else -> anything_else
    end
  end

  # other steps ...

  def process(input, fun) do
    case input do
      {:ok, value} -> {:ok, fun.(value)}
      anything_else -> anything_else
    end
  end
end

defmodule Demo do
  import OkComputer.Pipe

  pipe Steps, ~>: :process
end
