require 'serialport'

CODE_TABLE_RU = {
  'A' => 0x80,
  'Б' => 0x81,
  'В' => 0x82,
  'Г' => 0x83,
  'Д' => 0x84,
  'Е' => 0x85,
  'Ё' => 0x85,
  'Ж' => 0x86,
  'З' => 0x87,
  'И' => 0x88,
  'Й' => 0x89,
  'К' => 0x8A,
  'Л' => 0x8B,
  'М' => 0x8C,
  'Н' => 0x8D,
  'О' => 0x8E,
  'П' => 0x8F,
  'Р' => 0x90,
  'С' => 0x91,
  'Т' => 0x92,
  'У' => 0x93,
  'Ф' => 0x94,
  'Х' => 0x95,
  'Ц' => 0x96,
  'Ч' => 0x97,
  'Ш' => 0xE8,
  'Щ' => 0xE9,
  'Ъ' => 0x9A,
  'Ы' => 0x9B,
  'Ь' => 0x9C,
  'Э' => 0x9D,
  'Ю' => 0x9E,
  'Я' => 0x9F,
  'а' => 0xA0,
  'б' => 0xA1,
  'в' => 0xA2,
  'г' => 0xA3,
  'д' => 0xA4,
  'е' => 0xA5,
  'ё' => 0xA5,
  'ж' => 0xA6,
  'з' => 0xA7,
  'и' => 0xA8,
  'й' => 0xA9,
  'к' => 0xAA,
  'л' => 0xAB,
  'м' => 0xAC,
  'н' => 0xAD,
  'о' => 0xAE,
  'п' => 0xAF,
  'р' => 0xE0,
  'с' => 0xE1,
  'т' => 0xE2,
  'у' => 0xE3,
  'ф' => 0xE4,
  'х' => 0xE5,
  'ц' => 0xE6,
  'ч' => 0xE7,
  'ш' => 0xE8,
  'щ' => 0xE9,
  'ъ' => 0xEC,
  'ы' => 0xEB,
  'ь' => 0xEA,
  'э' => 0xED,
  'ю' => 0xEE,
  'я' => 0xEF,
  'Ә' => 0xF0,
  'ә' => 0xF8,
  'Ғ' => 0xF1,
  'ғ' => 0xF9,
  'Қ' => 0xF2,
  'қ' => 0xFA,
  'Ң' => 0xF3,
  'ң' => 0xFB,
  'Ө' => 0xF4,
  'ө' => 0xFC,
  'Ұ' => 0xF5,
  'ұ' => 0xFD,
  'Ү' => 0xF6,
  'ү' => 0xFE,
  'Һ' => 0xF7,
  'һ' => 0xF7,
  'І' => 0x49,
  'i' => 0x69,
  "\n" => 0x0A,
  "\r" => 0x0D,
}


class DisplayService
  def self.show_hello
    string = DisplayService.code_string 'Добро пожаловать'
    DisplayService.write string
  end

  def self.show_price price
    string = DisplayService.code_string("Приятного аппетита\n\rИтого: #{price} тг.")
    DisplayService.write string
  end

  private
  def self.code_string string
    string.split('').map do |char|
      CODE_TABLE_RU.has_key?(char) ? CODE_TABLE_RU[char] : char.unpack('c')[0]
    end
  end

  def self.write string
    if DEBUG
      puts string.inspect
    else
      port = SerialPort.new '/dev/ttyS0', 9600
      port.write [0x0C].pack('C*')
      port.write string.pack('C*')
      port.close
    end
  end

end