require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Explicitly require scoped_search to ensure it's loaded
require 'scoped_search'
begin
  require 'authlogic'
rescue LoadError
  puts "Authlogic not available, using basic session management"
end

module Cms
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.time_zone = "UTC"
    # config.eager_load_paths << Rails.root.join("extras")

    # Add additional load paths for your own custom dirs
    # config.eager_load_paths << Rails.root.join("app/models/cms")

    # Force all environments to use the same logger level
    # (by default production uses :info, the others :debug)
    # config.log_level = :debug
  end
end
