class Product
  include Mongoid::Document
  field :name, type: :string
  field :sku, type: :string
  field :price, type: :float
  index({sku: 1}, {unique: true})

  has_many :reviews

  def self.create_products
    (1..30).each do |i|
      name = Faker::Name.name
      sku = Faker::Code.asin
      price = Faker::Number.positive
      Product.create!(name: name, sku: sku, price: price)
    end
  end
end
