defmodule OkComputer.Example.FileIO do
  def cat(path) do
    with {:ok, file} <- File.open(path, [:read]) do
      {:ok, data} <-
        IO.read file do
          IO.inspect(data: data)
        end
    end
  end
end
