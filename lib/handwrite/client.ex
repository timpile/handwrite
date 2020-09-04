defmodule Handwrite.Client do
  @moduledoc """
  Responsible for setting up the base configuration to make requests to the Handwrite API.
  """

  @spec base_url :: String.t()
  def base_url, do: "https://api.handwrite.io/v1"

  @spec headers :: [{String.t(), String.t()}, ...]
  def headers do
    [
      {"content-type", "application/json"},
      {"authorization", "#{secret_key()}"}
    ]
  end

  defp secret_key do
    System.get_env("HANDWRITE_API_KEY")
  end
end
