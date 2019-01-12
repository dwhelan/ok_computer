defmodule OkComputer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ok_computer,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~> 0.0"},
    ]
  end
end
