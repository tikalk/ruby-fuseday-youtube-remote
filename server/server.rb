require "bundler/setup"
require "sinatra"
require "haml"

get "/" do
  "Hello world!"
end

post "/form" do
  url = params[:url]
  id = url.match(/.+\?v=(.+)$/){ $1 }
  haml: :result
end
