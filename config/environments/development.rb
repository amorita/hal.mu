Hal::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.action_mailer.raise_delivery_errors = true
config.action_mailer.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "gmail.com",
  :authentication => :login,
  :user_name => "info@hal.mu",
  :password => "infohaloke"
}

config.action_mailer.default_url_options = { :host => 'r.hal.mu' }
config.action_mailer.asset_host = "http://r.hal.mu"
config.secret_key_base = '8aac1206c766d9576cab4a94a1d3c05126ddacc1b2ad530afac29ccce2f5f86f6541795515505d835fea9af106e05f5a59618e19de938bbc1df2a953a3190369'

end
