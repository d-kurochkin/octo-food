require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

require './services/article_service'
require './services/order_service'
require './services/display_service'
require './services/session_service'

DATA_PATH = './data/'
SESSION_FILE = 'current_session.ekz'
DEBUG = false

register Sinatra::Reloader
set :bind, '0.0.0.0'

# Загружаем данные из файла
ArticleService.import

get '/' do
  puts 'ok'
  if SessionService.exist?
    erb :index
  else
    erb :session_new
  end
end

get '/session/start' do
  SessionService.start unless SessionService.exist?
  redirect to ''
end

get '/session/info' do
  @session = SessionService.get_current
  erb :session_info
end

get '/session/close' do
  SessionService.close if SessionService.exist?
  redirect to ''
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

get '/reload' do
  ArticleService.import
  redirect to '/'
end

post '/order' do
  OrderService.process params
  '0'
end


# get '/display/price/:price' do
#   price = params[:price]
#   DisplayService.show_price price
# end
#
# get '/display/hello' do
#   DisplayService.show_hello
# end