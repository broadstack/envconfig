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
      @_services = {}
    end

    def to_h
      [
        :database,
        :memcached,
        :redis,
        :smtp,
      ].inject({}) do |hash, service|
        hash.merge!(service => public_send(service).to_h)
      end
    end

    def database
      service_for(:database, Database)
    end

    def database?
      predicate_for(:database)
    end

    def memcached
      service_for(:memcached, Memcached)
    end

    def memcached?
      predicate_for(:memcached)
    end

    def redis
      service_for(:redis, Redis)
    end

    def redis?
      predicate_for(:redis)
    end

    def smtp
      service_for(:smtp, Smtp)
    end

    def smtp?
      predicate_for(:smtp)
    end

    private

    def service_for(name, klass)
      @_services[name] || klass.new(@env)
    end

    def predicate_for(name)
      public_send(name).to_h.any?
    end

  end

end
