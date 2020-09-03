defmodule HandwriteTest do
  use ExUnit.Case, async: true
  doctest Handwrite

  describe "Testing Endpoint urls" do
    setup do
      [
        base_url: "https://api.handwrite.io/v1",
        handwriting_url: "https://api.handwrite.io/v1/handwriting",
        order_url: "https://api.handwrite.io/v1/order/my_order_id",
        send_url: "https://api.handwrite.io/v1/send",
        stationary_url: "https://api.handwrite.io/v1/stationery"
      ]
    end

    test "base url", fixture do
      assert Handwrite.Client.base_url() == fixture.base_url
    end

    test "handwriting endpoint url", fixture do
      assert Handwrite.Endpoint.Handwriting.url() == fixture.handwriting_url
    end

    test "order endpoint url", fixture do
      assert Handwrite.Endpoint.Order.url("my_order_id") == fixture.order_url
    end

    test "send endpoint url", fixture do
      assert Handwrite.Endpoint.Send.url() == fixture.send_url
    end

    test "stationary endpoint url", fixture do
      assert Handwrite.Endpoint.Stationery.url() == fixture.stationary_url
    end
  end
end
