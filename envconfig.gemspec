# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envconfig/version'

Gem::Specification.new do |spec|
  spec.name          = "envconfig"
  spec.version       = Envconfig::VERSION
  spec.authors       = ["Paul Annesley"]
  spec.email         = ["paul@annesley.cc"]
  spec.description   = %q{Connect your app to backing services via Broadstack/Heroku-style ENV vars.}
  spec.summary       = %q{envconfig gathers ENV configuration from known add-on providers, exposes them as a consistent configuration interface, and configures your Rails application via initializers.

}
  spec.homepage      = "https://github.com/broadstack/envconfig"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end