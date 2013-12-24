require 'em-websocket'
require 'em-hiredis'


before do
  puts '[Params]'
  p params
end

get "/" do
  haml :controller
end

get "/test" do
  erb :client
end

post "/form" do
  url = params[:url]
  @id = url.match(/.+\?v=(.+)$/){ $1 }
  haml :result
end
