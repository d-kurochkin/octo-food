require 'nori'

MAPPINGS = {
    '@MKOD' => 'code',
    '@MNAIM' => 'name',
    '@MISGROUP' => 'is_group',
    '@MPARENT' => 'M',
    '@PRICE' => '956'
}

file = File.new './menu.ekz'
content = file.read

parser = Nori.new
result = parser.parse(content)
items = result['N']['NOM']

articles = items.map { |item| Hash[item.map {|k, v| [MAPPINGS[k], v] }]}


puts articles.inspect