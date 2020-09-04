defmodule Handwrite.Endpoint.Order do
  @moduledoc """
  Module responsible for making requests to the Order endpoint.

  ### Example usage
  ```
  Handwrite.Endpoint.Order.get("5dba45e8f2b173cb5dff0300")
  ```
  """

  import Handwrite.Client
  import Handwrite.Response

  @spec get(String.t()) :: {:error, any} | {:ok, any}
  def get(id) do
    url(id)
    |> HTTPoison.get(headers())
    |> handle_response()
  end

  @spec url(String.t()) :: String.t()
  def url(id), do: "#{base_url()}/order/#{id}"
end
