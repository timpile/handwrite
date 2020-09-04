defmodule Handwrite.MixProject do
  use Mix.Project

  def project do
    [
      app: :handwrite,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Handwrite",
      source_url: "https://github.com/timpile/handwrite",
      homepage_url: "https://github.com/timpile/handwrite",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "An unofficial Elixir library for working with the Handwrite.io API."
  end

  defp package() do
    [
      files: ~w(lib test .formatter.exs mix.exs README.md CHANGELOG.md .env_example),
      licenses: [],
      links: %{"GitHub" => "https://github.com/timpile/handwrite"}
    ]
  end

  defp docs() do
    [
      main: "Handwrite",
      extras: ["README.md"]
    ]
  end
end
