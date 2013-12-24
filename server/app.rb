require 'em-websocket'
require 'em-hiredis'
require 'json/ext'
require 'sinatra/flash'

before do
  puts '[Params]'
  p params
end

get "/" do
  redis = Redis.new
  @viewed_items = redis.smembers "recently-viewed"
  haml :controller
end

get "/test" do
  erb :client
end

post "/form" do
  url = params[:url]
  @id = url.match(/.+\?v=(.+)$/){ $1 }

  video = VideoInfo.new("http://www.youtube.com/watch?v=#{@id}")
  video_hash = {id: video.video_id, title: video.title, description: video.description, thumbnail: video.thumbnail_medium}.to_json
  redis = Redis.new
  redis.sadd "recently-viewed", video_hash

  flash[:result] = @id

  puts "channel - "+$channel.inspect
  puts 'subscribing to redis'
  $channel.push("22222")

  redirect "/"  
end
