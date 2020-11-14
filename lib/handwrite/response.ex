defmodule Handwrite.Response do
  @moduledoc """
  Handles parsing responses from the Handwrite API.
  """

  @enforce_keys [:status, :body]

  defstruct status: nil,
            body: nil

  @type t() :: %__MODULE__{
          status: integer(),
          body: any
        }

  @spec parse({:error, any} | {:ok, Tesla.Env.t()}) ::
          {:error, Handwrite.Response.t()} | {:ok, Handwrite.Response.t()}
  def parse(response) do
    case response do
      {:ok, %Tesla.Env{} = env} ->
        case env.status do
          200 ->
            {:ok, %Handwrite.Response{status: env.status, body: parse_body(env.body)}}

          _ ->
            {:error, %Handwrite.Response{status: env.status, body: parse_body(env.body)}}
        end

      {:error, message} ->
        {:error, %Handwrite.Response{status: nil, body: message}}
    end
  end

  defp parse_body([h | list]), do: [keys_to_atoms(h) | parse_body(list)]
  defp parse_body([]), do: []
  defp parse_body(%{} = body), do: keys_to_atoms(body)

  defp keys_to_atoms(body) do
    body |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end
end
