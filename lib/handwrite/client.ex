defmodule Handwrite.Client do
  @moduledoc """
  Client responsible for making requests to Handwrite and handling the responses.
  """

  def secret_key do
    System.get_env("HANDWRITE_API_KEY")
  end

  def base_url, do: "https://api.handwrite.io/v1"

  def headers do
    [
      {"content-type", "application/json"},
      {"authorization", "#{secret_key()}"}
    ]
  end

  def encode_recipients([%Handwrite.Recipient{} = recipient | recipients]) do
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

  def encode_recipients([]), do: []

  def encode_letter(%Handwrite.Letter{} = letter) do
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
    |> Poison.encode!()
  end
end
