defmodule Helpers.Response.Handwritings do
  def get_response(:ok_200) do
    {:ok,
     %Tesla.Env{
       body: [
         %{
           "_id" => "5dc306b0bc08d20016f1ec34",
           "name" => "Tribeca",
           "preview_url" =>
             "http://res.cloudinary.com/handwrite/image/upload/v1573062284/cards/ow07ohjuuojfqizhcspa.jpg"
         },
         %{
           "_id" => "5dc30652bc08d20016f1ec33",
           "name" => "Jeremy",
           "preview_url" =>
             "http://res.cloudinary.com/handwrite/image/upload/v1573062203/cards/udephlqp4foo3ijnteai.jpg"
         }
       ],
       method: :get,
       status: 200,
       url: "https://api.handwrite.io/v1/handwriting"
     }}
  end
end
