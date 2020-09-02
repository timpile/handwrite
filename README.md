# Handwrite

An Elixir library for working with [Handwrite.io](https://documentation.handwrite.io/)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `handwrite` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:handwrite, "~> 0.1.0"}
  ]
end
```

## Configuration

To make API calls, it is necessary to configure your Handwrite API key.

```elixir
use Mix.Config

config :handwrite, api_key: System.get_env("HANDWRITE_API_KEY")
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/handwrite](https://hexdocs.pm/handwrite).

