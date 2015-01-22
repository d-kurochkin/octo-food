require 'gyoku'

class OrderService
  def self.process params
    timestamp = params[:timestamp]
    xml = Gyoku.xml(params)
    path = "./data/order_#{timestamp}.ekz"

    File.write(path, xml)
  end
end
