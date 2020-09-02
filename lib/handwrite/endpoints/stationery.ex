defmodule Handwrite.Endpoint.Stationery do
  @moduledoc """
  Module responsible for making requests to the Stationery endpoint.

  ### Example usage
  ```
  Handwrite.Endpoint.Stationery.get()
  ```

  ### Example OK Response
  ```
  {:ok,
    [
      %{
        "_id" => "5dc304cfbc08d20016f1ec2f",
        "name" => "Good Job",
        "preview_url" =>
          "http://res.cloudinary.com/handwrite/image/upload/v1573061834/cards/anmowdxgikmgaqnvwvzs.jpg"
      },
      %{
        "_id" => "5dc30239bc08d20016f1ec27",
        "name" => "Classic Hello",
        "preview_url" =>
          "http://res.cloudinary.com/handwrite/image/upload/v1573061167/cards/rrxybnar4bkkwmbjbajj.jpg"
      }
    ]}
  ```
  """
  import Handwrite.Client
  import Handwrite.Response

  def url, do: "#{base_url()}/stationery"

  def get do
    url()
    |> HTTPoison.get(headers())
    |> handle_response()
  end
end
