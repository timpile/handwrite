defmodule Handwrite.Response do
  @moduledoc """
  Handles interpreting responses from the Handwrite API.
  """

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:error, any} | {:ok, any}
  def handle_response({:ok, %HTTPoison.Response{body: body}} = _response) do
    response_body = body |> parse_json()

    case response_body do
      %{"message" => message} ->
        {:error, message}

      _ ->
        {:ok, response_body}
    end
  end

  @spec handle_response({:error, HTTPoison.Error.t()}) :: {:error, any}
  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  defp parse_json(json_str) do
    Poison.Parser.parse!(json_str, %{})
  end
end
