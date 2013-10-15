require "envconfig"

module Envconfig
  class Railtie < Rails::Railtie

    envconfig = Envconfig.load(ENV)

    initializer "envconfig.smtp" do |app|
      if envconfig.smtp?
        envconfig_log "Using #{envconfig.smtp.provider.name} for SMTP"
        app.config.action_mailer.smtp_settings = envconfig.smtp.to_h
      else
        envconfig_log "SMTP not configured"
      end
    end

    def envconfig_log(message)
      Rails.logger.info("Envconfig: #{message}")
    end

  end
end
