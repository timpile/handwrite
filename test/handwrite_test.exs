defmodule HandwriteTest do
  use ExUnit.Case, async: true
  import Tesla.Mock

  doctest Handwrite

  @handwriting_url "https://api.handwrite.io/v1/handwriting"
  @stationary_url "https://api.handwrite.io/v1/stationery"
  @send_url "https://api.handwrite.io/v1/send"
  @order_url "https://api.handwrite.io/v1/order"
  @valid_order_id "valid_order_id"
  @bad_order_id "bad_order_id"
  @valid_api_key "valid_api_key"
  @bad_api_key "bad_api_key"
  @unauthorized_message "No token provided. Please make sure to include it in your headers, e.g. Authorization: test_HW_asdfasdfasdf"

  @valid_recipient %Handwrite.Model.Recipient{
    first_name: "First",
    last_name: "Last",
    street1: "543 Market St",
    city: "San Francisco",
    state: "CA",
    zip: "54321"
  }

  @valid_sender %Handwrite.Model.Sender{
    first_name: "First",
    last_name: "Last",
    street1: "123 6 Mile",
    street2: nil,
    city: "Detroit",
    state: "MI",
    zip: "12345"
  }

  @valid_letter %Handwrite.Model.Letter{
    message: "Hey! Thanks for being awesome.",
    handwriting: "5dc306b0bc08d20016f1ec34",
    card: "5dc304cfbc08d20016f1ec2f",
    recipients: [@valid_recipient],
    from: @valid_sender
  }

  describe "401 Response" do
    setup do
      mock(fn
        %{method: :get, url: @handwriting_url} ->
          Helpers.Response.Auth.get_response(:error_401)

        %{method: :get, url: @stationary_url} ->
          Helpers.Response.Auth.get_response(:error_401)

        %{method: :get, url: "#{@order_url}/#{@valid_order_id}"} ->
          Helpers.Response.Auth.get_response(:error_401)

        %{method: :post, url: @send_url} ->
          Helpers.Response.Auth.get_response(:error_401)
      end)

      :ok
    end

    test "list_handwritings" do
      client = Handwrite.client(api_key: @bad_api_key)

      assert {:error, resp} = Handwrite.list_handwritings(client)
      assert resp.status == 401
      assert resp.body.message == @unauthorized_message
    end

    test "list_stationeries" do
      client = Handwrite.client(api_key: @bad_api_key)

      assert {:error, resp} = Handwrite.list_stationeries(client)
      assert resp.status == 401
      assert resp.body.message == @unauthorized_message
    end

    test "get_order" do
      client = Handwrite.client(api_key: @bad_api_key)

      assert {:error, resp} = Handwrite.get_order(client, @valid_order_id)
      assert resp.status == 401
      assert resp.body.message == @unauthorized_message
    end

    test "send_letter" do
      client = Handwrite.client(api_key: @bad_api_key)
      letter = @valid_letter

      assert {:error, resp} = Handwrite.send_letter(client, letter)
      assert resp.status == 401
      assert resp.body.message == @unauthorized_message
    end
  end

  describe "200 Response" do
    setup do
      mock(fn
        %{method: :get, url: @handwriting_url} ->
          Helpers.Response.Handwritings.get_response(:ok_200)

        %{method: :get, url: @stationary_url} ->
          Helpers.Response.Stationeries.get_response(:ok_200)

        %{method: :get, url: "#{@order_url}/#{@valid_order_id}"} ->
          Helpers.Response.Order.get_response(:ok_200, @valid_order_id)

        %{method: :post, url: @send_url} ->
          Helpers.Response.Send.post_response(:ok_200)
      end)

      :ok
    end

    test "list_handwritings" do
      client = Handwrite.client(api_key: @valid_api_key)

      assert {:ok, resp} = Handwrite.list_handwritings(client)
      assert resp.status == 200

      assert resp.body == [
               %{
                 _id: "5dc306b0bc08d20016f1ec34",
                 name: "Tribeca",
                 preview_url:
                   "http://res.cloudinary.com/handwrite/image/upload/v1573062284/cards/ow07ohjuuojfqizhcspa.jpg"
               },
               %{
                 _id: "5dc30652bc08d20016f1ec33",
                 name: "Jeremy",
                 preview_url:
                   "http://res.cloudinary.com/handwrite/image/upload/v1573062203/cards/udephlqp4foo3ijnteai.jpg"
               }
             ]
    end

    test "list_stationeries" do
      client = Handwrite.client(api_key: @valid_api_key)

      assert {:ok, resp} = Handwrite.list_stationeries(client)
      assert resp.status == 200

      assert resp.body == [
               %{
                 _id: "5dc304cfbc08d20016f1ec2f",
                 name: "Good Job",
                 preview_url:
                   "http://res.cloudinary.com/handwrite/image/upload/v1573061834/cards/anmowdxgikmgaqnvwvzs.jpg"
               },
               %{
                 _id: "5dc30239bc08d20016f1ec27",
                 name: "Classic Hello",
                 preview_url:
                   "http://res.cloudinary.com/handwrite/image/upload/v1573061167/cards/rrxybnar4bkkwmbjbajj.jpg"
               }
             ]
    end

    test "get_order" do
      client = Handwrite.client(api_key: @valid_api_key)

      assert {:ok, resp} = Handwrite.get_order(client, @valid_order_id)
      assert resp.status == 200
      assert resp.body._id == @valid_order_id
    end

    test "send_letter" do
      client = Handwrite.client(api_key: @valid_api_key)

      assert {:ok, resp} = Handwrite.send_letter(client, @valid_letter)
      assert resp.status == 200

      assert resp.body == [
               %{
                 _id: "5f6b5c09c77c9a00171c5304",
                 card: "5dc304cfbc08d20016f1ec2f",
                 centerContentType: "address",
                 createdAt: "2020-09-23T14:30:33.787Z",
                 environment: "test",
                 from: %{
                   "city" => "Detroit",
                   "state" => "MI",
                   "street1" => "123 6 Mile",
                   "street2" => "",
                   "zip" => "12345"
                 },
                 handwriting: "5dc306b0bc08d20016f1ec34",
                 hasReturnAddress: true,
                 hasStamp: true,
                 inEnvelope: true,
                 message: "Hey! Thanks for being awesome.",
                 origin: "api",
                 priority: 1,
                 proofs: [],
                 selfSend: false,
                 status: "processing",
                 to: %{
                   "city" => "San Francisco",
                   "state" => "CA",
                   "street1" => "543 Market St",
                   "zip" => "54321"
                 },
                 updatedAt: "2020-09-23T14:30:33.787Z",
                 user: "5f44742632c77600179c0996"
               }
             ]
    end
  end

  describe "400 Response - Order Not Found" do
    setup do
      mock(fn
        %{method: :get, url: "#{@order_url}/#{@bad_order_id}"} ->
          Helpers.Response.Order.get_response(:error_400, @bad_order_id)
      end)

      :ok
    end

    test "get_order" do
      client = Handwrite.client(api_key: @valid_api_key)

      assert {:error, resp} = Handwrite.get_order(client, @bad_order_id)
      assert resp.status == 400
      assert resp.body.message == "No order found in your organization with that ID"
    end
  end

  describe "creating a letter" do
    test "with valid data" do
      assert {:ok, letter} = Handwrite.Model.Letter.encode(@valid_letter)
    end

    test "with a missing message" do
      invalid_letter = @valid_letter |> Map.put(:message, nil)

      assert {:error, message} = Handwrite.Model.Letter.encode(invalid_letter)
      assert message == "A message is required"
    end

    test "with a missing handwriting" do
      invalid_letter = @valid_letter |> Map.put(:handwriting, nil)

      assert {:error, message} = Handwrite.Model.Letter.encode(invalid_letter)
      assert message == "A handwriting is required"
    end

    test "with a missing card" do
      invalid_letter = @valid_letter |> Map.put(:card, nil)

      assert {:error, message} = Handwrite.Model.Letter.encode(invalid_letter)
      assert message == "A card is required"
    end

    test "with a missing recipient" do
      invalid_letter = @valid_letter |> Map.put(:recipients, nil)

      assert {:error, message} = Handwrite.Model.Letter.encode(invalid_letter)
      assert message == "A recipient is required"

      invalid_letter = @valid_letter |> Map.put(:recipients, [])

      assert {:error, message} = Handwrite.Model.Letter.encode(invalid_letter)
      assert message == "A recipient is required"
    end

    test "with an invalid recipient" do
      invalid_recipient = @valid_recipient |> Map.put(:first_name, nil)
      invalid_letter = @valid_letter |> Map.put(:recipients, [invalid_recipient])

      assert {:error, message} = Handwrite.Model.Letter.encode(invalid_letter)
      assert message == "A recipient's first name is required"
    end

    test "with multiple valid recipients" do
      valid_letter =
        @valid_letter
        |> Map.put(:recipients, [@valid_recipient, @valid_recipient])

      assert {:ok, letter} = Handwrite.Model.Letter.encode(valid_letter)
    end

    test "with multiple recipients and one is invalid" do
      invalid_recipient = @valid_recipient |> Map.put(:first_name, nil)

      valid_letter =
        @valid_letter
        |> Map.put(:recipients, [@valid_recipient, invalid_recipient])

      assert {:error, message} = Handwrite.Model.Letter.encode(valid_letter)
      assert message == "A recipient's first name is required"
    end
  end

  describe "creating a recipient" do
    test "with valid data" do
      assert {:ok, recipient} = Handwrite.Model.Recipient.encode([@valid_recipient])
      assert recipient == [Map.from_struct(@valid_recipient)]
    end

    test "with a missing name" do
      invalid_recipient = @valid_recipient |> Map.put(:first_name, nil)

      assert {:error, message} = Handwrite.Model.Recipient.encode([invalid_recipient])
      assert message == "A recipient's first name is required"

      invalid_recipient = @valid_recipient |> Map.put(:last_name, nil)

      assert {:error, message} = Handwrite.Model.Recipient.encode([invalid_recipient])
      assert message == "A recipient's last name is required"
    end

    test "with a missing address" do
      invalid_recipient = @valid_recipient |> Map.put(:street1, nil)

      assert {:error, message} = Handwrite.Model.Recipient.encode([invalid_recipient])
      assert message == "A recipient's address requires a street"

      invalid_recipient = @valid_recipient |> Map.put(:city, nil)

      assert {:error, message} = Handwrite.Model.Recipient.encode([invalid_recipient])
      assert message == "A recipient's address requires a city"

      invalid_recipient = @valid_recipient |> Map.put(:state, nil)

      assert {:error, message} = Handwrite.Model.Recipient.encode([invalid_recipient])
      assert message == "A recipient's address requires a state"

      invalid_recipient = @valid_recipient |> Map.put(:zip, nil)

      assert {:error, message} = Handwrite.Model.Recipient.encode([invalid_recipient])
      assert message == "A recipient's address requires a zip"
    end
  end

  describe "creating a sender" do
    test "with valid data" do
      assert {:ok, sender} = Handwrite.Model.Sender.encode(@valid_sender)
      assert sender == Map.from_struct(@valid_sender)
    end

    test "with a missing name" do
      invalid_sender = @valid_sender |> Map.put(:first_name, nil)

      assert {:error, message} = Handwrite.Model.Sender.encode(invalid_sender)
      assert message == "A sender's first name is required"

      invalid_sender = @valid_sender |> Map.put(:last_name, nil)

      assert {:error, message} = Handwrite.Model.Sender.encode(invalid_sender)
      assert message == "A sender's last name is required"
    end

    test "with a missing address" do
      invalid_sender = @valid_sender |> Map.put(:street1, nil)

      assert {:error, message} = Handwrite.Model.Sender.encode(invalid_sender)
      assert message == "A sender's address requires a street"

      invalid_sender = @valid_sender |> Map.put(:city, nil)

      assert {:error, message} = Handwrite.Model.Sender.encode(invalid_sender)
      assert message == "A sender's address requires a city"

      invalid_sender = @valid_sender |> Map.put(:state, nil)

      assert {:error, message} = Handwrite.Model.Sender.encode(invalid_sender)
      assert message == "A sender's address requires a state"

      invalid_sender = @valid_sender |> Map.put(:zip, nil)

      assert {:error, message} = Handwrite.Model.Sender.encode(invalid_sender)
      assert message == "A sender's address requires a zip"
    end
  end
end
