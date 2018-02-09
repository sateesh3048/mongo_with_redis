class Review
  include Mongoid::Document
  field :description, type: String
  field :rating, type: Integer
  field :product_id, type: BSON::ObjectId

  belongs_to :product


  def self.create_reviews
    product_ids = Product.pluck(:id)
    ratings =[1,2,3,4,5]
    (1..5000).each do |id|
      description = Faker::Lorem.sentence(3)
      rating = ratings.sample
      product_id = product_ids.sample
      Review.create!(description: description, rating: rating, product_id: product_id)
    end
  end
end
