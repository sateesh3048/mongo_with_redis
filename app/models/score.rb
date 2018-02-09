class Score
  include Mongoid::Document
  field :author, type: String
  field :score, type: Integer
  field :views, type: Integer
end
