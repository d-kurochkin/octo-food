DATA_PATH = './data/'
SESSION_FILE = 'current_session.ekz'

class SessionService
  def self.get_current
    path = DATA_PATH + SESSION_FILE

    File.open path, 'r' do |file|
      file.readline
    end
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

  def self.close
    source_path = DATA_PATH + SESSION_FILE

    File.rename source_path, target_path
  end
end

SessionService.start