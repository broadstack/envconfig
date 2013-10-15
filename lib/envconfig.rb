require "envconfig/provider"
require "envconfig/service"
require "envconfig/smtp"
require "envconfig/version"

module Envconfig

  def self.load(env)
    Root.new(env)
  end

  class Root

    def initialize(env)
      @env = env
    end

    def smtp
      @_smtp ||= ::Envconfig::Smtp.new(@env)
    end

    def smtp?
      smtp.to_h.any?
    end

  end

end
