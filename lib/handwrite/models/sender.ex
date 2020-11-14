defmodule Handwrite.Model.Sender do
  @moduledoc """
  Represents the name and address of the person sending the card.

  ## Example

  ```elixir
  %Handwrite.Model.Sender{
    first_name: "First",
    last_name: "Last",
    street1: "123 6 Mile",
    street2: nil,
    city: "Detroit",
    state: "MI",
    zip: "12345"
  }
  ```
  """

  @enforce_keys [:first_name, :last_name, :street1, :city, :state, :zip]

  defstruct first_name: nil,
            last_name: nil,
            street1: nil,
            street2: nil,
            city: nil,
            state: nil,
            zip: nil

  @type t() :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          street1: String.t(),
          street2: String.t() | nil,
          city: String.t(),
          state: String.t(),
          zip: String.t()
        }

  @doc """
  Encoding, in this case, means converting a `%Sender{}` struct into a simple map, but providing validation feedback in the process.

  Typically, you shouldn't need to call `encode` directly, as it is handled inside of the `send_letter` function.

  ## Example

  ```
  iex> sender = %Handwrite.Model.Sender{...}
  iex> Handwrite.Model.Sender.encode(sender)
  ```

  Returns one of the following:

  ```
  {:ok, %{...}}
  {:error, "A sender's first name is required"}
  {:error, "A sender's last name is required"}
  {:error, "A sender's address requires a street"}
  {:error, "A sender's address requires a city"}
  {:error, "A sender's address requires a state"}
  {:error, "A sender's address requires a zip"}
  ```
  """
  @spec encode(Handwrite.Model.Sender.t()) :: {:error, String.t()} | {:ok, map}
  def encode(%Handwrite.Model.Sender{} = sender) do
    case validate(sender) do
      {:ok, valid_sender} ->
        {:ok, Map.from_struct(valid_sender)}

      {:error, message} ->
        {:error, message}
    end
  end

  defp validate(%Handwrite.Model.Sender{first_name: nil}) do
    {:error, "A sender's first name is required"}
  end

  defp validate(%Handwrite.Model.Sender{last_name: nil}) do
    {:error, "A sender's last name is required"}
  end

  defp validate(%Handwrite.Model.Sender{street1: nil}) do
    {:error, "A sender's address requires a street"}
  end

  defp validate(%Handwrite.Model.Sender{city: nil}) do
    {:error, "A sender's address requires a city"}
  end

  defp validate(%Handwrite.Model.Sender{state: nil}) do
    {:error, "A sender's address requires a state"}
  end

  defp validate(%Handwrite.Model.Sender{zip: nil}) do
    {:error, "A sender's address requires a zip"}
  end

  defp validate(%Handwrite.Model.Sender{} = sender), do: {:ok, sender}
end
