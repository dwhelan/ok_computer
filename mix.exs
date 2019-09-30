defmodule OkComputer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ok_computer,
      version: "0.1.0",
      name: "ok_computer",
      description: "Pipes and things to remove conditional logic",
      source_url: "https://github.com/dwhelan/ok_computer",
      package: package(),
      elixir: "~> 1.7",
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        build: :test
      ],
      default_task: "build"
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      build: ["format", "compile", "docs", "dialyzer"]
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
