defmodule Handwrite.Endpoint.Handwriting do
  @moduledoc """
  Module responsible for making requests to the Handwriting endpoint.

  ### Example usage
  ```
  Handwrite.Endpoint.Handwriting.get()
  ```

  ### Example OK Response
  ```
  {:ok,
    [
      %{
        "_id" => "5dc306b0bc08d20016f1ec34",
        "name" => "Tribeca",
        "preview_url" =>
          "http://res.cloudinary.com/handwrite/image/upload/v1573062284/cards/ow07ohjuuojfqizhcspa.jpg"
      },
      %{
        "_id" => "5dc30652bc08d20016f1ec33",
        "name" => "Jeremy",
        "preview_url" =>
          "http://res.cloudinary.com/handwrite/image/upload/v1573062203/cards/udephlqp4foo3ijnteai.jpg"
      }
    ]}
  ```
  """

  import Handwrite.Client
  import Handwrite.Response

  @spec get :: {:error, any} | {:ok, any}
  def get do
    url()
    |> HTTPoison.get(headers())
    |> handle_response()
  end

  @spec url :: String.t()
  def url, do: "#{base_url()}/handwriting"
end
