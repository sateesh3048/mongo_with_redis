class Order
  include Mongoid::Document
  field :qty, type: Integer
  field :price, type: Float
  field :orderd_date, type: Date


  def self.orders_collection
    (1..100).each do |id|
      qty=(1..10).to_a.sample
      price = (1..1000).to_a.sample
      orderd_date = [Date.today, Date.today-1, Date.today-2,Date.today-3, Date.today-4, Date.today-5, Date.today-6, Date.today-7].sample
      Order.create!(qty: qty, price: price, orderd_date: orderd_date)
    end
  end
end
