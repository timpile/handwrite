defmodule Handwrite.Endpoint.Send do
  @moduledoc """
  Module responsible for making requests to the Send endpoint.

  ### Example usage
  ```
  letter = %Handwrite.Model.Letter{
      message: "Hey! Thanks for being awesome.",
      handwriting: "5db6f0724cc1751452c5ae8e",
      card: "5db6f0724cc1751452c5ae8e",
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
      from: %Handwrite.Model.From{
        first_name: "First",
        last_name: "Last",
        street1: "123 6 Mile",
        street2: "",
        city: "Detroit",
        state: "MI",
        zip: "12345"
      }
    }

  Handwrite.Endpoint.Send.post(letter)
  ```
  """

  import Handwrite.Client
  import Handwrite.Response

  @spec post(Handwrite.Model.Letter.t()) :: {:error, any} | {:ok, any}
  def post(%Handwrite.Model.Letter{} = letter) do
    url()
    |> HTTPoison.post(request_body(letter), headers())
    |> handle_response()
  end

  @spec url :: String.t()
  def url, do: "#{base_url()}/send"

  defp request_body(%Handwrite.Model.Letter{} = letter) do
    letter
    |> encode_letter()
    |> Poison.encode!()
  end

  defp encode_letter(%Handwrite.Model.Letter{} = letter) do
    %{
      "message" => letter.message,
      "handwriting" => letter.handwriting,
      "card" => letter.card,
      "recipients" => encode_recipients(letter.recipients),
      "from" => %{
        "firstName" => letter.from.first_name,
        "lastName" => letter.from.last_name,
        "street1" => letter.from.street1,
        "street2" => letter.from.street2,
        "city" => letter.from.city,
        "state" => letter.from.state,
        "zip" => letter.from.zip
      }
    }
  end

  defp encode_recipients([%Handwrite.Model.Recipient{} = recipient | recipients]) do
    [
      %{
        "firstName" => recipient.first_name,
        "lastName" => recipient.last_name,
        "street1" => recipient.street1,
        "city" => recipient.city,
        "state" => recipient.state,
        "zip" => recipient.zip
      }
      | encode_recipients(recipients)
    ]
  end

  defp encode_recipients([]), do: []
end
