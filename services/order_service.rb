require 'gyoku'
require './services/session_service'

class OrderService
  def self.process params
    timestamp = params[:timestamp]
    session = SessionService.get_current
    path = "./data/#{session[:id]}/order_#{timestamp}.ekz"

    File.write path, Gyoku.xml(params)

    SessionService.update params['total'].to_i
  end
end
