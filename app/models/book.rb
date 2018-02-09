class Book
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  field :title, type: String
  field :content, type: String
  field :status, type: String
  field :published_date, type: Date


   def self.query_match
    self.search query: {
      "match_all": { }
    }, "size": 20#, "from": 10 , "size": 20

   end

   def self.sort_by_published_date
    self.search query: {
      "match_all": {}
    }, "size": 20,
    "sort": {published_date: {"order": "desc"}},
    "_source": ["title", "published_date"]
   end


  def self.active_books
    self.search query: {
      match: {status: "Active"}
    }#.records.to_a
  end

  def self.in_active_and_nil_books
    self.search query:{
      match: { status: "nil InActive" }
    }
  end

  def self.active_and_nil_status_books
    self.search query: {
      bool: {
        must_not: [
           {match: {status: "Active"}},
           {match: {status: "InActive"}}


        ]
      }
    }
  end

  def self.filter_by_pub_date
    self.search query:{
      filtered: {
        query: {match_all: {} },
        filter: {
          range: {
            published_date: {
              gte: Date.today-10.days,
              lte: Date.today+90.days
            }
          }
        }
      }
    }
  end



   def self.group_by_status
    self.search query: {
      match_all: {}
    },
    fields: [:title, :status]
   end


  def self.store_data
    Book.create(title: "title", content: "content", status: "Active", published_date: Date.today-10.days)
    Book.create(title: "Rails", content: "Ror content", status: "Active", published_date: Date.today+20.days)
    Book.create(title: "Ruby", content: "Basic R content", status: "Active", published_date: Date.today-30.days)
    Book.create(title: "Ruby on Rails", content: "Ror with content", status: "Active", published_date: Date.today+40.days)
    Book.create(title: "Css", content: "Cascading Style Sheet", status: "InActive", published_date: Date.today-50.days)
    Book.create(title: "Html", content: "Hyper text content", status: "Active", published_date: Date.today-60.days)
    Book.create(title: "Html with css", content: "content", status: "InActive", published_date: Date.today-90.days)
    Book.create(title: "Javascript", content: "Learing Javascript ", status: "Active", published_date: Date.today+90.days)
    Book.create(title: "Learing material", content: "WFA", status: "Active", published_date: Date.today+90.days)
    Book.create(title: "R content Basci", content: "Ruby", status: "Active", published_date: Date.today+120.days)
    Book.create(title: "Nil Title", content: "Nil content", status: nil, published_date: Date.today+10.days)
    Book.create(title: "S:starts", content: "K:checks", status: nil, published_date: Date.today+10.days)

  end

  def self.wildcard_query
    self.search query: { 
      "wildcard": { "status": "Ac*"}
    }
  end

  def self.exists_query
    self.search query: {
      "exists": {"field": "status"}
    }
  end

  def self.prefix_query
    self.search query: {
       "prefix": {"title": "S"}

    }
  end

  def self.published_range
    self.search query: {
      "range": {
        "published_date": {
          "gte": "2016-01-01",
          "lte": "2016-11-01"
        }
      }
    }
  end



  def self.search_multi_terms
    self.search query:{
      "constant_score": {
        "filter": {
          "terms": {"content": ["content", "test"] }
        }
      }
    }
  end


  def self.multi_field_search
    self.search query:{
      "multi_match":{
        "query": "R content",
        "fields": ["title", "content^3"],
        "type": "best_fields",
        "operator": "or"
      }
    }
  end



  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end


  def self.bsearch
    self.search query:{
      bool: {
        must: [
          { match: { title: "Ruby" } },
          { match: { content: "content" }}
        ],
        filter: [
          { "term": { "status": "Active" }},
          { range:{ published_date: {"gte": "2016-06-01"}}}
        ]
      }
    }
  end

  def self.term_query 
    self.search query: {
      term: { title: "Javascript" }
    }
  end

  def self.phrase_query
    self.search query: {

      "match": {
        "content": {
          "query": "content",
          "operator": "and"
        }
      }
    }
  end
end
