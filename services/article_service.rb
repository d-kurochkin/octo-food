require 'nori'

require './models'

MAPPINGS = {
    '@MKOD' => 'code',
    '@MNAIM' => 'name',
    '@MISGROUP' => 'is_group',
    '@MPARENT' => 'parent',
    '@PRICE' => 'price'
}

PAGE_LIMIT = 20

class ArticleService
  def self.load
    file = File.new DATA_PATH + 'menu.ekz'
    parser = Nori.new

    items = parser.parse(file.read)['N']['NOM']

    items.map! { |item| Hash[item.map {|k, v| [MAPPINGS[k], v] }]}
    items.map do |item|
      item.tap do |i|
        i['is_group'] =i['is_group'].to_i
        i['price'] =i['price'].to_f
      end
    end
  end

  def self.import
    Article.all.each { |item| item.delete }
    ArticleService.load.each { |article| Article.insert(article) }
    puts "Импортировано записей: #{Article.count}"
  end

  def self.get_page category, page
    Article.where(:parent => category)
        .order(Sequel.asc(:name))
        .limit(PAGE_LIMIT, page*PAGE_LIMIT)
        .map { |item| item.values }
  end

  def self.get_parent category
    if category == 'M'
      'M'
    else
      Article.where(:code => category).first.values[:parent]
    end
  end

  def self.get_count category
    count = Article.where(:parent => category).count
    (count.to_f / PAGE_LIMIT).ceil
  end
end