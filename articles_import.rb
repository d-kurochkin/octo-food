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
  def self.get
    items = ArticlesImport.load
    ArticlesImport.transform items
  end

  private
  def self.load
    file = File.new IMPORT_PATH
    parser = Nori.new

    parser.parse(file.read)['N']['NOM']
  end

  def self.transform items
    items.map! { |item| Hash[item.map {|k, v| [MAPPINGS[k], v] }]}
    items.map do |item|
      item.tap do |i|
        i['is_group'] =i['is_group'].to_i
        i['price'] =i['price'].to_f
      end
    end
  end
end