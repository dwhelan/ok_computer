defmodule OkComputer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ok_computer,
      version: "0.1.0",
      name: "ok_computer",
      description: "Supports railroad style processing for ok and error values.",
      source_url: "https://github.com/dwhelan/ok_computer",
      package: package(),
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [build: :test],
      default_task: "build"
    ]
  end

  def application do
    []
  end

  defp elixirc_paths(:test), do: ["lib", "test/lily/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      build: ["clean", "format", "dialyzer", "compile", "docs", "test"]
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
