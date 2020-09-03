defmodule Fixture.Response.Order do
  def get_response(:ok) do
    {:ok,
     %{
       "_id" => "5f471194a99db9001786e646",
       "card" => "5ee796dedb3dce23d4c19edf",
       "createdAt" => "2020-08-27T01:51:16.517Z",
       "environment" => "test",
       "from" => %{
         "city" => "Detroit",
         "firstName" => "Tim",
         "lastName" => "P.",
         "state" => "MI",
         "street1" => "123 6 Mile",
         "zip" => "12345"
       },
       "handwriting" => "5dc306b0bc08d20016f1ec34",
       "message" => "Hi John,\r\n\r\nThanks for everything!\r\n\r\nYour buddy,\r\nTim",
       "proofs" => [
         %{
           "image_url" =>
             "https://order-proofs.s3.us-east-2.amazonaws.com/c08a2c96-72a6-4bae-8755-3a35788e99df.jpg",
           "job_type" => "card"
         }
       ],
       "status" => "processing",
       "to" => %{
         "city" => "Detroit",
         "firstName" => "John",
         "lastName" => "M.",
         "state" => "MI",
         "street1" => "123 6 Mile",
         "zip" => "12345"
       }
     }}
  end

  def get_response(:not_valid) do
    {:error, "Order ID is not valid"}
  end

  def get_response(:not_found) do
    {:error, "Not Found!"}
  end

  def get_response(:no_auth_token) do
    {:error,
     "No token provided. Please make sure to include it in your headers, e.g. Authorization: test_HW_asdfasdfasdf"}
  end

  def post_response(:ok) do
    {:ok,
     [
       %{
         "_id" => "5f4fa90e08a1bc0017f36a9a",
         "card" => "5ee796dedb3dce23d4c19edf",
         "centerContentType" => "address",
         "createdAt" => "2020-09-02T14:15:42.944Z",
         "environment" => "test",
         "from" => %{
           "city" => "Detroit",
           "firstName" => "Tim",
           "lastName" => "P",
           "state" => "MI",
           "street1" => "123 6 Mile",
           "street2" => "",
           "zip" => "12345"
         },
         "handwriting" => "5dc306b0bc08d20016f1ec34",
         "hasReturnAddress" => true,
         "hasStamp" => true,
         "inEnvelope" => true,
         "jobGenerated" => false,
         "message" => "Hi John,\r\n\r\nThanks for everything!\r\n\r\nYour buddy,\r\nTim",
         "origin" => "api",
         "priority" => 1,
         "proofs" => [],
         "selfSend" => false,
         "status" => "processing",
         "to" => %{
           "city" => "San Francisco",
           "firstName" => "John",
           "lastName" => "M.",
           "state" => "CA",
           "street1" => "543 Market St",
           "zip" => "54321"
         },
         "updatedAt" => "2020-09-02T14:15:42.944Z",
         "user" => "5f44742632c77600179c0996"
       }
     ]}
  end
end
