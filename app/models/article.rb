class Article
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  field :title, :type => String

  def self.search(query)
    # ...
  end


  def self.create_lists
    Article.create title: 'Quick brown fox'
    Article.create title: 'Fast black dogs'
    Article.create title: 'Swift green frogs'
  end
end
