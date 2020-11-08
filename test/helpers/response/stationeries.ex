defmodule Helpers.Response.Stationeries do
  def get_response(:ok_200) do
    {:ok,
     %Tesla.Env{
       body: [
         %{
           "_id" => "5dc304cfbc08d20016f1ec2f",
           "name" => "Good Job",
           "preview_url" =>
             "http://res.cloudinary.com/handwrite/image/upload/v1573061834/cards/anmowdxgikmgaqnvwvzs.jpg"
         },
         %{
           "_id" => "5dc30239bc08d20016f1ec27",
           "name" => "Classic Hello",
           "preview_url" =>
             "http://res.cloudinary.com/handwrite/image/upload/v1573061167/cards/rrxybnar4bkkwmbjbajj.jpg"
         }
       ],
       method: :get,
       status: 200,
       url: "https://api.handwrite.io/v1/stationery"
     }}
  end
end
