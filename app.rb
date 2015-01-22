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

get '/articles/*.*' do |category, page|
  @articles = ArticleModel.get_page category, page.to_i
  erb :articles, :layout => false, :locals => {page: page, articles:@articles}
end


