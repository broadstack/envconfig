require "envconfig/abstract_provider"
require "envconfig/provider_resolver"
require "envconfig/root"
require "envconfig/service"
require "envconfig/smtp"
require "envconfig/version"

module Envconfig

  def self.from(env)
    ::Envconfig::Root.new(env)
  end

end
