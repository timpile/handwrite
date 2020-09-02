defmodule Handwrite.Endpoint.Send do
  @moduledoc """
  Module responsible for making requests to the Send endpoint.

  ### Example usage
  ```
  letter = %Handwrite.Letter{
      message: "Hey! Thanks for being awesome.",
      handwriting: "asdfasdfasdfasdf",
      card: "asdfasdfasdfasdf",
      recipients: [
        %Handwrite.Recipient{
          first_name: "First",
          last_name: "Last",
          street1: "543 Market St",
          city: "San Francisco",
          state: "CA",
          zip: "54321"
        }
      ],
      from: %Handwrite.From{
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

  def url, do: "#{base_url()}/send"

  def post(%Handwrite.Letter{} = letter) do
    url()
    |> HTTPoison.post(encode_letter(letter), headers())
    |> handle_response()
  end
end
