defmodule Helpers.Response.Auth do
  def get_response(:error_401) do
    {:ok,
     %Tesla.Env{
       body: %{
         "message" =>
           "No token provided. Please make sure to include it in your headers, e.g. Authorization: test_HW_asdfasdfasdf"
       },
       method: :get,
       status: 401,
       url: "https://api.handwrite.io/v1/handwriting"
     }}
  end
end
