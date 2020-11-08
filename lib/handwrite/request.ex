defmodule Handwrite.Request do
  @moduledoc """
  Handles making REST calls to the Handwrite API.
  """

  alias Handwrite.Response

  @spec get(Tesla.Client.t(), String.t()) :: {:error, Response.t()} | {:ok, Response.t()}
  def get(client, url) do
    client
    |> Tesla.get(url)
    |> Response.parse()
  end

  @spec post(Tesla.Client.t(), String.t(), any) :: {:error, Response.t()} | {:ok, Response.t()}
  def post(client, url, body) do
    client
    |> Tesla.post(url, body)
    |> Response.parse()
  end
end
