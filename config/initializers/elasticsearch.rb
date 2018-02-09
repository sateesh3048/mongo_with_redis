# Elasticsearch::Model.client = Elasticsearch::Client.new url: "http://skambhampati:Epam1234@localhost:9200/"


Elasticsearch::Model.client = Elasticsearch::Client.new url: "http://localhost:9200/"


# unless User.__elasticsearch__.index_exists?
#   User.__elasticsearch__.create_index! force: true
#   User.import
# end