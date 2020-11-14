defmodule Handwrite.MixProject do
  use Mix.Project

  def project do
    [
      app: :handwrite,
      version: "1.0.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Handwrite",
      source_url: "https://github.com/timpile/handwrite",
      homepage_url: "https://github.com/timpile/handwrite",
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/helpers"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "An Elixir library for working with the Handwrite.io API."
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG* .env_example),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/timpile/handwrite"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
