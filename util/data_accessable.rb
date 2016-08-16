require "redis"
require "singleton"
require_relative '../config'

module NuviApplication
  class DataAccessable
    include Singleton

    def initialize
      @redis = Redis.new(:host => Config.instance.redis['host'], :port => Config.instance.redis['port'], :db => Config.instance.redis['db'])
    end

    def push_to_list(list, value)
      @redis.lpush(list, value)
    end

    def get_all_elements(list)
      @redis.lrange(list, 0, -1)
    end
    
    def redis
      @redis
    end

  end
end