class Category
  include Mongoid::Document
  # include Mongoid::Timestamps::Created
  # include Mongoid::Paranoia
  include CommonMeta


  # timestamps!

  
  cattr_accessor :bulk

  after_save :reset_cache , unless: -> { Category.bulk.present? }

  def self.fetch_categories
    # $redis.del "categories"
    categories =  $redis.get("categories")
    if categories.blank?
      categories = Category.order(name: :asc).to_json
      $redis.set("categories", categories)
      $redis.expire("categories", 3.hours.to_i)
    end

    categories = JSON.load(categories) 
    # categories = categories.compact.map { |hsh| Category.new(hsh)}
   # models = jsons.compact.map { |json| Klass.new(JSON.parse(json)) }
    # JSON.load(categories)
    categories
  end

  def reset_cache
    puts "I am in Reset Cached Operation"
    $redis.del "categories"
  end
end
