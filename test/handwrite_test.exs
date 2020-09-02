defmodule HandwriteTest do
  use ExUnit.Case
  doctest Handwrite

  test "Endpoint urls" do
    base_url = "https://api.handwrite.io/v1"

    assert Handwrite.Client.base_url() == base_url
    assert Handwrite.Endpoint.Handwriting.url() == "#{base_url}/handwriting"
    assert Handwrite.Endpoint.Order.url("my_order_id") == "#{base_url}/order/my_order_id"
    assert Handwrite.Endpoint.Send.url() == "#{base_url}/send"
    assert Handwrite.Endpoint.Stationery.url() == "#{base_url}/stationery"
  end
end
