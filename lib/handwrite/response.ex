defmodule Handwrite.Response do
  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    response_body = body |> parse_json()

    case response_body do
      %{"message" => message} ->
        {:error, message}

      _ ->
        {:ok, response_body}
    end
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def parse_json(json_str) do
    Poison.Parser.parse!(json_str, %{})
  end
end
