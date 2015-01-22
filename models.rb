require 'sequel'

require './articles_import'

DB = Sequel.sqlite

DB.create_table :articles do
  primary_key :id
  String :code
  String :name
  String :parent
  Boolean :is_group
  Float :price
end

class Article < Sequel::Model;
end

# Populate the table
ArticlesImport.get.each { |article| Article.insert(article)}



# Print out the number of records
# puts Article.where.delete

# Print out the average price
puts "Импортировано записей: #{Article.count}"