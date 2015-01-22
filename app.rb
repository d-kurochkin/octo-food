require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

require './models'

register Sinatra::Reloader
set :bind, '0.0.0.0'

# Загружаем данные из файла
ArticleModel.import

get '/' do
  erb :index
end

get '/articles/*.*' do |category, page|
  @page = page.to_i
  @count = ArticleModel.get_count category
  if @count > 0
    @articles = ArticleModel.get_page category, @page
    @parent = ArticleModel.get_parent @articles.first[:parent]
    erb :articles, :layout => false, :locals => {category: category, parent: @parent, total: @count, page: @page, articles: @articles}
  else
    status 404
  end
end


