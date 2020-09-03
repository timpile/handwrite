defmodule Handwrite.MixProject do
  use Mix.Project

  def project do
    [
      app: :handwrite,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Handwrite",
      source_url: "https://github.com/timpile/handwrite",
      homepage_url: "https://github.com/timpile/handwrite",
      docs: [
        main: "Handwrite",
        extras: ["README.md"]
      ]
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
end
