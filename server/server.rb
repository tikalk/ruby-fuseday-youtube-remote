require "bundler/setup"
require "sinatra"
require "haml"

get "/" do
  erb :controller
end

post "/form" do
  url = params[:url]
  id = url.match(/.+\?v=(.+)$/){ $1 }
  haml: :result
end
