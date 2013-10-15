module Envconfig

  # The root configuration accessor.
  # Gives access to various services e.g. root.smtp[:username]
  class Root

    def initialize(env)
      @env = env
    end

    def smtp
      ::Envconfig::Smtp.new(env)
    end

    private

    attr_reader :env

  end
end
