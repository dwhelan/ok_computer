defmodule OkComputer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ok_computer,
      version: "0.1.0",
      name: "ok_computer",
      description: "Monads and do-syntax for Elixir",
      source_url: "https://github.com/rmies/monad",
      package: package(),
      elixir: "~> 1.7",
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:mix_test_watch, "~> 0.8",  only: :dev},
      {:ex_doc,         "~> 0.19", only: :dev, runtime: false},
    ]
  end

  defp package() do
    [
      maintainers: ["Declan Whelan"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/dwhelan/ok_computer"}
    ]
  end
end
