defmodule Helpers.Response.Send do
  def post_response(:ok_200) do
    {:ok,
     %Tesla.Env{
       body: [
         %{
           "_id" => "5f6b5c09c77c9a00171c5304",
           "card" => "5dc304cfbc08d20016f1ec2f",
           "centerContentType" => "address",
           "createdAt" => "2020-09-23T14:30:33.787Z",
           "environment" => "test",
           "from" => %{
             "city" => "Detroit",
             "state" => "MI",
             "street1" => "123 6 Mile",
             "street2" => "",
             "zip" => "12345"
           },
           "handwriting" => "5dc306b0bc08d20016f1ec34",
           "hasReturnAddress" => true,
           "hasStamp" => true,
           "inEnvelope" => true,
           "message" => "Hey! Thanks for being awesome.",
           "origin" => "api",
           "priority" => 1,
           "proofs" => [],
           "selfSend" => false,
           "status" => "processing",
           "to" => %{
             "city" => "San Francisco",
             "state" => "CA",
             "street1" => "543 Market St",
             "zip" => "54321"
           },
           "updatedAt" => "2020-09-23T14:30:33.787Z",
           "user" => "5f44742632c77600179c0996"
         }
       ],
       method: :post,
       status: 200,
       url: "https://api.handwrite.io/v1/send"
     }}
  end

  def post_response(:error_401, :blank_message) do
    {:ok,
     %Tesla.Env{
       __client__: %Tesla.Client{
         adapter: nil,
         fun: nil,
         post: [],
         pre: [
           {Tesla.Middleware.BaseUrl, :call, ["https://api.handwrite.io/v1"]},
           {Tesla.Middleware.JSON, :call, [[]]},
           {Tesla.Middleware.Headers, :call, [[{"authorization", "test_HW_asdfasdfasdf"}]]}
         ]
       },
       __module__: Tesla,
       body: %{"message" => "Message can't be blank"},
       headers: [
         {"connection", "keep-alive"},
         {"date", "Wed, 23 Sep 2020 14:19:57 GMT"},
         {"via", "1.1 vegur"},
         {"etag", "W/\"24-Yx+asEeba8A3HX0YEd5MisDJeeg\""},
         {"server", "Cowboy"},
         {"vary", "Origin, X-HTTP-Method-Override, Accept-Encoding"},
         {"content-length", "36"},
         {"content-type", "application/json; charset=utf-8"},
         {"x-powered-by", "Express"},
         {"x-ratelimit-limit", "60"},
         {"x-ratelimit-remaining", "59"},
         {"x-ratelimit-reset", "1600870801"}
       ],
       method: :post,
       opts: [],
       query: [],
       status: 401,
       url: "https://api.handwrite.io/v1/send"
     }}
  end

  def post_response(:error_401, :does_not_exist) do
    {:ok,
     %Tesla.Env{
       __client__: %Tesla.Client{
         adapter: nil,
         fun: nil,
         post: [],
         pre: [
           {Tesla.Middleware.BaseUrl, :call, ["https://api.handwrite.io/v1"]},
           {Tesla.Middleware.JSON, :call, [[]]},
           {Tesla.Middleware.Headers, :call, [[{"authorization", "test_HW_asdfasdfasdf"}]]}
         ]
       },
       __module__: Tesla,
       body: %{
         "message" =>
           "Stationery with ID 5db6f0724cc1751452c5ae8e does not exist. Please make sure you are using a valid stationery ID"
       },
       headers: [
         {"connection", "keep-alive"},
         {"date", "Wed, 23 Sep 2020 14:25:41 GMT"},
         {"via", "1.1 vegur"},
         {"etag", "W/\"7e-fccYt7bxEc7hVh+60mSvGPr4DJ0\""},
         {"server", "Cowboy"},
         {"vary", "Origin, X-HTTP-Method-Override, Accept-Encoding"},
         {"content-length", "126"},
         {"content-type", "application/json; charset=utf-8"},
         {"x-powered-by", "Express"},
         {"x-ratelimit-limit", "60"},
         {"x-ratelimit-remaining", "59"},
         {"x-ratelimit-reset", "1600871161"}
       ],
       method: :post,
       opts: [],
       query: [],
       status: 401,
       url: "https://api.handwrite.io/v1/send"
     }}
  end

  def post_response(:error_401, :blank_recipient) do
    {:ok,
     %Tesla.Env{
       __client__: %Tesla.Client{
         adapter: nil,
         fun: nil,
         post: [],
         pre: [
           {Tesla.Middleware.BaseUrl, :call, ["https://api.handwrite.io/v1"]},
           {Tesla.Middleware.JSON, :call, [[]]},
           {Tesla.Middleware.Headers, :call, [[{"authorization", "test_HW_asdfasdfasdf"}]]}
         ]
       },
       __module__: Tesla,
       body: %{"message" => "Recipients can't be blank"},
       headers: [
         {"connection", "keep-alive"},
         {"date", "Wed, 23 Sep 2020 14:28:30 GMT"},
         {"via", "1.1 vegur"},
         {"etag", "W/\"27-EZrwx9lVDcUUXzPpF1DmNiK8Zfc\""},
         {"server", "Cowboy"},
         {"vary", "Origin, X-HTTP-Method-Override, Accept-Encoding"},
         {"content-length", "39"},
         {"content-type", "application/json; charset=utf-8"},
         {"x-powered-by", "Express"},
         {"x-ratelimit-limit", "60"},
         {"x-ratelimit-remaining", "59"},
         {"x-ratelimit-reset", "1600871341"}
       ],
       method: :post,
       opts: [],
       query: [],
       status: 401,
       url: "https://api.handwrite.io/v1/send"
     }}
  end

  def post_repsonse(:error_401, :invalid_handwriting) do
    {:ok,
     %Tesla.Env{
       __client__: %Tesla.Client{
         adapter: nil,
         fun: nil,
         post: [],
         pre: [
           {Tesla.Middleware.BaseUrl, :call, ["https://api.handwrite.io/v1"]},
           {Tesla.Middleware.JSON, :call, [[]]},
           {Tesla.Middleware.Headers, :call, [[{"authorization", "test_HW_asdfasdfasdf"}]]}
         ]
       },
       __module__: Tesla,
       body: %{
         "message" =>
           "Handwriting with ID 5db6f0724cc1751452c5ae8e does not exist. Please make sure you are using a valid handwriting ID"
       },
       headers: [
         {"connection", "keep-alive"},
         {"date", "Wed, 23 Sep 2020 14:27:08 GMT"},
         {"via", "1.1 vegur"},
         {"etag", "W/\"80-vTwdcpEcgUcy1VsZ2nD+rQ7g3nU\""},
         {"server", "Cowboy"},
         {"vary", "Origin, X-HTTP-Method-Override, Accept-Encoding"},
         {"content-length", "128"},
         {"content-type", "application/json; charset=utf-8"},
         {"x-powered-by", "Express"},
         {"x-ratelimit-limit", "60"},
         {"x-ratelimit-remaining", "59"},
         {"x-ratelimit-reset", "1600871281"}
       ],
       method: :post,
       opts: [],
       query: [],
       status: 401,
       url: "https://api.handwrite.io/v1/send"
     }}
  end
end
