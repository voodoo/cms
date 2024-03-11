require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cms
  class Application < Rails::Application

    config.autoload_paths += %W(
      #{config.root}/app/models/concerns
    )

    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   #:tls => true,
    #   :address => "smtp.gmail.com",
    #   :port => "587",
    #   :domain => "integrated-internet.com",
    #   :authentication => :plain,
    #   :user_name => Rails.application.secrets["emails"]["ii"]["email"],
    #   :password => Rails.application.secrets["emails"]["ii"]["pwd"]
    # }    
    # config.middleware.use ExceptionNotification::Rack, email: {
    #   email_prefix: "[Exception] ",
    #   sender_address: %{"Exception Notifier" <support@integrated-internet.com>},
    #   exception_recipients: %w{paul.vudmaska@gmail.com elva.tristan@gmail.com}      
    # }


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true


  end
end
