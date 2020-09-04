# Handwrite

An unofficial Elixir library for working with [Handwrite.io](https://documentation.handwrite.io/)

## Documentation

Once published, the docs can be found at [https://hexdocs.pm/handwrite](https://hexdocs.pm/handwrite).

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

Add the `HANDWRITE_API_KEY` environment variable to your `.env` file.

It should look like this (or see the `.env_example`).
```
HANDWRITE_API_KEY=test_HW_asdfasdfasdf
```

Then make sure the environment variables are loaded and accessible via `System.get_env("HANDWRITE_API_KEY")` when your application starts.
