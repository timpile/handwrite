defmodule Handwrite do
  @moduledoc """
  An Elixir wrapper for the [Handwrite](https://handwrite.io/) API.

  ## Installation

  The package can be installed by adding `handwrite` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:handwrite, "~> 0.2.0"}
    ]
  end
  ```

  ## Configuration

  To make API calls, it is necessary to configure your Handwrite API key. Add the following line to your `config.exs` file.

  ```elixir
  config :my_app, :handwrite, api_key: "test_HW_asdfasdfasdf"
  ```

  ## Usage

  ```
  handwrite_config = Application.get_env(:my_app, :handwrite)
  client = Handwrite.client(handwrite_config)
  ```
  """

  alias Handwrite.{Model, Request, Response}
  alias Tesla

  @base_url "https://api.handwrite.io/v1"
  @handwriting_url "#{@base_url}/handwriting"
  @stationery_url "#{@base_url}/stationery"
  @send_url "#{@base_url}/send"
  @order_url "#{@base_url}/order"

  @spec client(keyword) :: Tesla.Client.t()
  def client(opts \\ []) do
    api_key = Keyword.fetch!(opts, :api_key)

    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", api_key}]}
    ]

    Tesla.client(middleware)
  end

  @doc """
  Gets a list of handwritings.

  ## Example

  ```
  Handwrite.list_handwritings(client)
  ```

  Returns one of the following:

  ```
  {:error, "Error message"}
  {:error, %Handwrite.Response{}}
  {:ok, %Handwrite.Response{}}
  ```
  """
  @spec list_handwritings(Tesla.Client.t()) ::
          {:error, String.t()} | {:error, %Response{}} | {:ok, %Response{}}
  def list_handwritings(client) do
    Request.get(client, @handwriting_url)
  end

  @doc """
  Gets a list of stationeries (aka cards).

  ## Example

  ```
  Handwrite.list_stationeries(client)
  ```

  Returns one of the following:

  ```
  {:error, "Error message"}
  {:error, %Handwrite.Response{}}
  {:ok, %Handwrite.Response{}}
  ```
  """
  @spec list_stationeries(Tesla.Client.t()) ::
          {:error, String.t()} | {:error, %Response{}} | {:ok, %Response{}}
  def list_stationeries(client) do
    Request.get(client, @stationery_url)
  end

  @doc """
  Gets an order by id.

  ## Example
  ```
  order_id =  "5f6b5c09c77c9a00171c5304"
  Handwrite.get_order(client, order_id)
  ```

  Returns one of the following:

  ```
  {:error, "Error message"}
  {:error, %Handwrite.Response{}}
  {:ok, %Handwrite.Response{}}
  ```
  """
  @spec get_order(Tesla.Client.t(), String.t()) ::
          {:error, String.t()} | {:error, %Response{}} | {:ok, %Response{}}
  def get_order(client, order_id) do
    Request.get(client, order_url(order_id))
  end

  @doc """
  Sends a letter, which creates and order.

  ## Example
  ```
  letter = %Handwrite.Model.Letter{
    card: "5dc304cfbc08d20016f1ec2f",
    from: %Handwrite.Model.Sender{
      city: "Detroit",
      first_name: "First",
      last_name: "Last",
      state: "MI",
      street1: "123 6 Mile",
      street2: nil,
      zip: "12345"
    },
    handwriting: "5dc306b0bc08d20016f1ec34",
    message: "Hey! Thanks for being awesome.",
    recipients: [
      %Handwrite.Model.Recipient{
        city: "San Francisco",
        first_name: "First",
        last_name: "Last",
        state: "CA",
        street1: "543 Market St",
        zip: "54321"
      }
    ]
  }
  Handwrite.send_letter(client, letter)
  ```

  Returns one of the following:

  ```
  {:error, "Error message"}
  {:error, %Handwrite.Response{}}
  {:ok, %Handwrite.Response{}}
  ```
  """
  @spec send_letter(Tesla.Client.t(), Model.Letter.t()) ::
          {:error, String.t()} | {:error, %Response{}} | {:ok, %Response{}}
  def send_letter(client, %Model.Letter{} = letter) do
    case Model.Letter.encode(letter) do
      {:ok, valid_letter} ->
        Request.post(client, @send_url, valid_letter)

      {:error, message} ->
        {:error, message}
    end
  end

  def send_letter(_, letter) when is_nil(letter), do: {:error, "Letter is required."}

  defp order_url(id), do: "#{@order_url}/#{id}"
end
