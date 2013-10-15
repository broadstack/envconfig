# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envconfig/version'

Gem::Specification.new do |spec|
  spec.name          = "envconfig-rails"
  spec.version       = Envconfig::VERSION
  spec.authors       = ["Paul Annesley"]
  spec.email         = ["paul@annesley.cc"]
  spec.summary       = %q{Auto-configure Rails from ENV vars via envconfig.}
  spec.homepage      = "https://github.com/broadstack/envconfig"
  spec.license       = "MIT"

  spec.files         = ["lib/envconfig-rails.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "envconfig", Envconfig::VERSION
end
