# This entire Rakefile (at time of writing), and the general model
# of multiple gemspecs in one project, was lifted from bkeepers/dotenv.
# See: https://github.com/bkeepers/dotenv/blob/master/Rakefile

require "bundler/gem_helper"

namespace "envconfig" do
  Bundler::GemHelper.install_tasks :name => "envconfig"
end

namespace "envconfig-rails" do
  class EnvconfigRailsGemHelper < Bundler::GemHelper
    def guard_already_tagged; end # noop
    def tag_version; end # noop
  end

  EnvconfigRailsGemHelper.install_tasks :name => "envconfig-rails"
end

task :build => ["envconfig:build", "envconfig-rails:build"]
task :install => ["envconfig:install", "envconfig-rails:install"]
task :release => ["envconfig:release", "envconfig-rails:release"]

require "rspec/core/rake_task"

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
  t.verbose = false
end

task :default => :spec
