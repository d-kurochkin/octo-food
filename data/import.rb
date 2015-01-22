require 'nori'
require 'sqlite3'

file = File.new './menu.ekz'
content = file.read

parser = Nori.new
result = parser.parse(content)
items = result['N']['NOM']


# puts items.inspect
require "sqlite3"

# Open a database
db = SQLite3::Database.new "test.db"