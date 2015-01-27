require 'fileutils'

DATA_PATH = '/home/pengo/.work/octo-food/data/'
SESSION_FILE = 'current_session.ekz'

class SessionService
  def self.get_current
    path = DATA_PATH + SESSION_FILE

    File.open path, 'r' do |file|
      @id = file.readline.gsub("\n", '')
      @total = file.readline.gsub("\n", '').to_i

    end

    {id: @id, total: @total}
  end

  def self.exist?
    File.exist?(DATA_PATH + SESSION_FILE)
  end

  def self.start
    time = Time.new.strftime '%Y%m%d%H%M%S'
    path = DATA_PATH + SESSION_FILE
    File.open path, 'w' do |file|
      file.write time
      file.write "\n"
      file.write 0
    end

    Dir.mkdir DATA_PATH + time
  end

  def self.update order_total
    puts order_total.inspect
    session = SessionService.get_current
    session[:total] = session[:total] + order_total

    File.open(DATA_PATH + SESSION_FILE, 'wb') { |f| f.write "#{session[:id]}\n#{session[:total]}" }
  end

  def self.close
    current_session = SessionService.get_current[:id]
    source_path = DATA_PATH + SESSION_FILE
    target_path = DATA_PATH + current_session + '/session.ekz'
    session = File.open(source_path, 'rb') { |f| f.read }

    time = Time.new.strftime '%Y%m%d%H%M%S'
    File.open(target_path, 'w+') { |f| f.write time }

    #Удаление старой сессии
    File.delete source_path
  end
end