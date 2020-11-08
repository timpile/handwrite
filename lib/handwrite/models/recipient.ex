defmodule Handwrite.Model.Recipient do
  @moduledoc """
  Represents the name and address of the person receiving the card.

  ## Example

  ```elixir
  %Handwrite.Model.Recipient{
    first_name: "First",
    last_name: "Last",
    street1: "543 Market St",
    city: "San Francisco",
    state: "CA",
    zip: "54321"
  }
  ```
  """

  @enforce_keys [:first_name, :last_name, :street1, :city, :state, :zip]

  defstruct first_name: nil,
            last_name: nil,
            street1: nil,
            city: nil,
            state: nil,
            zip: nil

  @type t() :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          street1: String.t(),
          city: String.t(),
          state: String.t(),
          zip: String.t()
        }

  @doc """
  Encoding, in this case, means converting a `%Recipient{}` struct into a simple map, but providing validation feedback in the process.

  Typically, you shouldn't need to call `encode` directly, as it is handled inside of the `send_letter` function.

  ## Example

  ```
  iex> recipient = %Handwrite.Model.Recipient{...}
  iex> Handwrite.Model.Recipient.encode(recipient)
  ```

  Returns one of the following:

  ```
  {:ok, %{...}}
  {:error, "A recipient's first name is required"}
  {:error, "A recipient's last name is required"}
  {:error, "A recipient's address requires a street"}
  {:error, "A recipient's address requires a city"}
  {:error, "A recipient's address requires a state"}
  {:error, "A recipient's address requires a zip"}
  ```
  """
  @spec encode([Handwrite.Model.Recipient.t()]) :: [] | {:error, any} | {:ok, list()}
  def encode(recipients) do
    recipients
    |> encode_recipient_list()
    |> validate_recipient_list()
  end

  defp encode_recipient_list([%Handwrite.Model.Recipient{} = recipient | recipients]) do
    [encode_recipient(recipient) | encode_recipient_list(recipients)]
  end

  defp encode_recipient_list([]), do: []

  defp encode_recipient(%Handwrite.Model.Recipient{} = recipient) do
    case validate(recipient) do
      {:ok, valid_recipient} ->
        Map.from_struct(valid_recipient)

      error ->
        error
    end
  end

  defp validate_recipient_list(recipients) do
    case List.keyfind(recipients, :error, 0) do
      {:error, message} ->
        {:error, message}

      nil ->
        {:ok, recipients}
    end
  end

  defp validate(%Handwrite.Model.Recipient{first_name: nil}) do
    {:error, "A recipient's first name is required"}
  end

  defp validate(%Handwrite.Model.Recipient{last_name: nil}) do
    {:error, "A recipient's last name is required"}
  end

  defp validate(%Handwrite.Model.Recipient{street1: nil}) do
    {:error, "A recipient's address requires a street"}
  end

  defp validate(%Handwrite.Model.Recipient{city: nil}) do
    {:error, "A recipient's address requires a city"}
  end

  defp validate(%Handwrite.Model.Recipient{state: nil}) do
    {:error, "A recipient's address requires a state"}
  end

  defp validate(%Handwrite.Model.Recipient{zip: nil}) do
    {:error, "A recipient's address requires a zip"}
  end

  defp validate(%Handwrite.Model.Recipient{} = recipient), do: {:ok, recipient}
end
