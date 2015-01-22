require 'nori'

MAPPINGS = {
    '@MKOD' => 'code',
    '@MNAIM' => 'name',
    '@MISGROUP' => 'is_group',
    '@MPARENT' => 'parent',
    '@PRICE' => 'price'
}

IMPORT_PATH = 'menu.ekz'

class ArticlesImport
  def self.load
    file = File.new IMPORT_PATH
    content = file.read

    parser = Nori.new
    result = parser.parse(content)
    result['N']['NOM']
  end

  def self.transform
    articles = items.map { |item| Hash[item.map {|k, v| [MAPPINGS[k], v] }]}
    articles.map do |item|
      item.tap do |i|
        i['is_group'] =i['is_group'].to_i
        i['price'] =i['price'].to_f
      end
    end
  end
end