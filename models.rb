require 'sequel'

DB = Sequel.sqlite

DB.create_table :articles do
  primary_key :id
  String :code
  String :name
  Boolean :is_group
  Float :price
end

class Article < Sequel::Model;
end


# Populate the table
Article.insert(:name => 'abc', :price => rand * 100)
Article.insert(:name => 'def', :price => rand * 100)
Article.insert(:name => 'ghi', :price => rand * 100)

# Print out the number of records
puts "Item count: #{Article.count}"

# Print out the average price
puts "The average price is: #{Article.avg(:price)}"