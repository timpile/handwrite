defmodule Handwrite.Endpoint.Order do
  @moduledoc """
  Module responsible for making requests to the Order endpoint.

  ### Example usage
  ```
  Handwrite.Endpoint.Order.get("5f471194a99db9001786e646")
  ```
  """

  import Handwrite.Client
  import Handwrite.Response

  def url(id), do: "#{base_url()}/order/#{id}"

  def get(id) do
    url(id)
    |> HTTPoison.get(headers())
    |> handle_response()
  end
end
