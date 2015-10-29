redis = Redis.new
namespaced_redis = Redis::Namespace.new(:instant_learn, redis: redis)
Redis::Objects.redis = namespaced_redis
