require 'sinatra'
require 'sinatra/reloader'
require 'erb'

register Sinatra::Reloader
set :bind, '0.0.0.0'

get '/' do
  erb :index
end

