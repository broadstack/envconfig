require "envconfig/service"
require "envconfig/provider"
require "envconfig/url_parser"

require "envconfig/database"
require "envconfig/memcached"
require "envconfig/redis"
require "envconfig/smtp"

require "envconfig/version"

module Envconfig

  def self.load(env = ENV)
    Root.new(env)
  end

  class Root

    def initialize(env)
      @env = env
    end

    def database
      @_database ||= ::Envconfig::Database.new(@env)
    end

    def database?
      database.to_h.any?
    end

    def memcached
      @_memcached ||= ::Envconfig::Memcached.new(@env)
    end

    def memcached?
      memcached.to_h.any?
    end

    def redis
      @_redis ||= ::Envconfig::Redis.new(@env)
    end

    def redis?
      redis.to_h.any?
    end

    def smtp
      @_smtp ||= ::Envconfig::Smtp.new(@env)
    end

    def smtp?
      smtp.to_h.any?
    end

  end

end
