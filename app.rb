require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

require './services/article_service'

register Sinatra::Reloader
set :bind, '0.0.0.0'

# Загружаем данные из файла
ArticleService.import

get '/' do
  erb :index
end

get '/articles/*.*' do |category, page|
  @page = page.to_i
  @count = ArticleService.get_count category
  if @count > 0
    @articles = ArticleService.get_page category, @page
    @parent = ArticleService.get_parent @articles.first[:parent]
    erb :articles, :layout => false, :locals => {category: category, parent: @parent, total: @count, page: @page, articles: @articles}
  else
    status 404
  end
end
