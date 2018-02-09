class Comment
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  field :name, type: String
  field :description, type: String
  

  
  def self.create_data
    Comment.create(name: "Testing_comment", description: "Testing Description")
    Comment.create(name: "Welcome_comment", description: "checking Description")
    Comment.create(name: "Validating_comment", description: "Verifying Description")
  end

  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end


  def self.search_comments
    self.search query: { match: { name: "Validating_comment"}},
              highlight: {fields: {name: "Testing"}}
  end
end
