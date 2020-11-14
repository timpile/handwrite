defmodule Helpers.Response.Order do
  def get_response(:ok_200, order_id) do
    {:ok,
     %Tesla.Env{
       body: %{
         "_id" => order_id,
         "card" => "5ee796dedb3dce23d4c19edf",
         "createdAt" => "2020-08-27T01:51:16.517Z",
         "environment" => "test",
         "from" => %{
           "city" => "Detroit",
           "firstName" => "Tim Pile",
           "lastName" => "",
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
       },
       method: :get,
       status: 200,
       url: "https://api.handwrite.io/v1/order/#{order_id}"
     }}
  end

  def get_response(:error_400, order_id) do
    {:ok,
     %Tesla.Env{
       body: %{"message" => "No order found in your organization with that ID"},
       method: :get,
       opts: [],
       query: [],
       status: 400,
       url: "https://api.handwrite.io/v1/order/#{order_id}"
     }}
  end
end
