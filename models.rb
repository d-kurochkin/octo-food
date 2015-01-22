require 'sequel'

require './articles_import'

DB = Sequel.sqlite

DB.create_table :articles do
  primary_key :id
  String :code
  String :name
  String :parent
  Fixnum :is_group
  Float :price
end

class Article < Sequel::Model;
end

# Populate the table
ArticlesImport.get.each { |article| Article.insert(article) }

# Print out the average price
puts "Импортировано записей: #{Article.count}"

class ArticleModel
  def self.get_page category, page
    Article.where(:parent => category).order(Sequel.desc(:is_group)).limit(12, page*12).map { |item| item.values }
  end
end