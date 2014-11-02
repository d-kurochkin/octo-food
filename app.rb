require 'sinatra'
require 'sinatra/reloader'
require 'erb'

register Sinatra::Reloader

get '/' do
  erb :index
end

