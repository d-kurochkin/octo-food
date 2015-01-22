require 'sequel'

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

