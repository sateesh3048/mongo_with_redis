$redis = Redis::Namespace.new("mongo_redis", :redis => Redis.new)