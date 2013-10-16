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
      predicate_for(:database)
    end

    def memcached
      @_memcached ||= ::Envconfig::Memcached.new(@env)
    end

    def memcached?
      predicate_for(:memcached)
    end

    def redis
      @_redis ||= ::Envconfig::Redis.new(@env)
    end

    def redis?
      predicate_for(:redis)
    end

    def smtp
      @_smtp ||= ::Envconfig::Smtp.new(@env)
    end

    def smtp?
      predicate_for(:smtp)
    end

    private

    def predicate_for(name)
      public_send(name).to_h.any?
    end

  end

end
