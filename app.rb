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
  @page = page.to_i
  @parent = 'M'
  @count = ArticleModel.get_count category
  @articles = ArticleModel.get_page category, @page

  erb :articles, :layout => false, :locals => {category:category, parent:@parent, total: @count, page: @page, articles:@articles}
end


