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
      ::Envconfig::Smtp.new(@env)
    end

  end

end
