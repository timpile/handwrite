# Handwrite

An Elixir library for working with [Handwrite.io](https://documentation.handwrite.io/)

## Documentation

Hex package details can be found at [https://hex.pm/packages/handwrite](https://hex.pm/packages/handwrite).

Detailed documentation can be found at [https://hexdocs.pm/handwrite](https://hexdocs.pm/handwrite).

## Installation

The package can be installed by adding `handwrite` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:handwrite, "~> 1.0.0"}
  ]
end
```

## Configuration

To make API calls, it is necessary to configure your Handwrite API key. Add the following line to your `config.exs` file.

```elixir
config :my_app, :handwrite, api_key: "test_HW_asdfasdfasdf"
```

## Usage

### Client

```elixir
handwrite_config = Application.get_env(:my_app, :handwrite)
client = Handwrite.client(handwrite_config)
```

### Get a List of Stationeries

```elixir
Handwrite.list_stationeries(client)
```

### Get a List of Handwritings

```elixir
Handwrite.list_handwritings(client)
```

### Get an Existing Order

```elixir
order_id = "5f6b5c09c77c9a00171c5304"
Handwrite.get_order(client, order_id)
```

### Send a Letter

```elixir
letter = %Handwrite.Model.Letter{
  card: "5dc304cfbc08d20016f1ec2f",
  from: %Handwrite.Model.Sender{
    city: "Detroit",
    first_name: "First",
    last_name: "Last",
    state: "MI",
    street1: "123 6 Mile",
    street2: nil,
    zip: "12345"
  },
  handwriting: "5dc306b0bc08d20016f1ec34",
  message: "Hey! Thanks for being awesome.",
  recipients: [
    %Handwrite.Model.Recipient{
      city: "San Francisco",
      first_name: "First",
      last_name: "Last",
      state: "CA",
      street1: "543 Market St",
      zip: "54321"
    }
  ]
}
Handwrite.send_letter(client, letter)
```
