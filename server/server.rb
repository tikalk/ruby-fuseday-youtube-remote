require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'

get "/" do
  haml :controller
end

post "/form" do
  url = params[:url]
  id = url.match(/.+\?v=(.+)$/){ $1 }
  haml :result
end
