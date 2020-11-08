defmodule Handwrite.Model.Letter do
  @moduledoc """
  Represents the a valid letter that can be sent via Handwrite.

  ## Example

  ```
  letter = %Handwrite.Model.Letter{
    message: "Hey! Thanks for being awesome.",
    handwriting: "5dc306b0bc08d20016f1ec34",
    card: "5dc304cfbc08d20016f1ec2f",
    recipients: [
      %Handwrite.Model.Recipient{
        first_name: "First",
        last_name: "Last",
        street1: "543 Market St",
        city: "San Francisco",
        state: "CA",
        zip: "54321"
      }
    ],
    from: %Handwrite.Model.Sender{
      first_name: "First",
      last_name: "Last",
      street1: "123 6 Mile",
      street2: nil,
      city: "Detroit",
      state: "MI",
      zip: "12345"
    }
  }
  ```
  """

  alias Handwrite.Model.{Recipient, Sender}

  @enforce_keys [:message, :handwriting, :card]

  defstruct message: nil,
            handwriting: nil,
            card: nil,
            recipients: [],
            from: nil

  @type t() :: %__MODULE__{
          message: String.t(),
          handwriting: String.t(),
          card: String.t(),
          recipients: list(%Handwrite.Model.Recipient{}),
          from: %Handwrite.Model.Sender{}
        }

  @doc """
  Encoding, in this case, means converting a `%Letter{}` struct into a simple map, but providing validation feedback in the process. `encode` is also called on the nested `Handwrite.Model.Sender` struct and list of `Handwrite.Model.Recipient` structs.

  Typically, you shouldn't need to call `encode` directly, as it is handled inside of the `send_letter` function.

  ## Example

  ```
  iex> letter = %Handwrite.Model.Letter{...}
  iex> Handwrite.Model.Letter.encode(letter)
  ```

  Returns one of the following:

  ```
  {:ok, %{...}}
  {:error, "A message is required"}
  {:error, "A handwriting is required"}
  {:error, "A card is required"}
  {:error, "A recipient is required"}

  {:error, "A recipient's first name is required"}
  {:error, "A recipient's last name is required"}
  {:error, "A recipient's address requires a street"}
  {:error, "A recipient's address requires a city"}
  {:error, "A recipient's address requires a state"}
  {:error, "A recipient's address requires a zip"}

  {:error, "A sender's first name is required"}
  {:error, "A sender's last name is required"}
  {:error, "A sender's address requires a street"}
  {:error, "A sender's address requires a city"}
  {:error, "A sender's address requires a state"}
  {:error, "A sender's address requires a zip"}
  ```
  """
  @spec encode(Handwrite.Model.Letter.t()) :: {:error, any} | {:ok, map}
  def encode(%Handwrite.Model.Letter{} = letter) do
    with {:ok, valid_letter} <- validate(letter),
         {:ok, valid_recipients} <- Recipient.encode(letter.recipients),
         {:ok, valid_sender} <- Sender.encode(letter.from) do
      {:ok,
       valid_letter
       |> Map.from_struct()
       |> Map.put(:recipients, valid_recipients)
       |> Map.put(:from, valid_sender)}
    end
  end

  defp validate(%Handwrite.Model.Letter{message: nil}) do
    {:error, "A message is required"}
  end

  defp validate(%Handwrite.Model.Letter{handwriting: nil}) do
    {:error, "A handwriting is required"}
  end

  defp validate(%Handwrite.Model.Letter{card: nil}) do
    {:error, "A card is required"}
  end

  defp validate(%Handwrite.Model.Letter{recipients: []}) do
    {:error, "A recipient is required"}
  end

  defp validate(%Handwrite.Model.Letter{recipients: nil}) do
    {:error, "A recipient is required"}
  end

  defp validate(%Handwrite.Model.Letter{} = letter), do: {:ok, letter}
end
