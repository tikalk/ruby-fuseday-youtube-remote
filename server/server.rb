require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
require 'mongo'
require 'json/ext'

include Mongo

configure do
#  conn = MongoClient.new("192.168.2.1", 27017)
#  set :mongo_connection, conn
#  set :mongo_db, conn.db('test')
end

before do
  puts '[Params]'
  p params
end

get "/" do
  haml :controller
end

post "/form" do
  url = params[:url]
  @id = url.match(/.+\?v=(.+)$/){ $1 }
  haml :result
end

get '/collections/?' do
  settings.mongo_db.collection_names
end
