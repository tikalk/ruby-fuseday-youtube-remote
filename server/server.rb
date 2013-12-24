require "bundler/setup"
require "sinatra"

get "/" do
  erb :controller
end
