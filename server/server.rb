require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'

get "/" do
  haml :controller
end
