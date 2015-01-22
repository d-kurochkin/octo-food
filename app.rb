require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

require './models'

register Sinatra::Reloader
set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/articles' do
  # content_type :json

  # @articles = Article.where(:parent => 'M').limit(12).map{|item| item.values}
  # @articles.to_json
  erb :articles, :layout => false, :locals => {:page => 10, :total => 50}
end


