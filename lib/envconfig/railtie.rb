require "envconfig"

module Envconfig
  class Railtie < Rails::Railtie

    envconfig = Envconfig.load(ENV)

    config.action_mailer.smtp_settings = envconfig.smtp.to_h

  end
end
