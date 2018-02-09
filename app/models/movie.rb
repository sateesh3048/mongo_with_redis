class Movie
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
 
  # Defining  
  field :name, type: String
  field :description, type: String
  field :language, type: String
  field  :rating, type: Integer

  mappings do
    indexes :name, type: 'string' 
    indexes :description, type: 'string'
  end


  def self.custom_search(params={})
    puts "params>>>>>params>>>>>params>>>>>params"
    puts params.inspect
    puts "dfadfjkdjslfakfljdkldjfskdjlfkjdlfskl"
    __elasticsearch__.search(
      "query": {
        "query_string": {
          "default_field": "_all",
          "query": params[:query]
        }        
      }
      )
  end


  def as_indexed_json(options={})
     as_json(only: [:name, :description])
  end

  def self.store_movie_results
    rating_ids = (1..5).to_a
    languages = ["telugu", "english", "hindi", "tamil", "kannada"]
    description_key_words = ["good", "best", "average", "worst"]
    name_words = ["nice", "andhra" , "telangana", "welcome", "good", "best", "average"]
    (1..100).each do |movie|
      name = Faker::Name.name
      description = Faker::Lorem.sentence(3)
      name = [name , name_words.sample].join(" ")
      description =[description,description_key_words.sample].join(" ")
      Movie.create(name: name, description: description, language: languages.sample, rating: rating_ids.sample)
    end
  end
 
end
