Yosistemas::Application.configure do
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
Recaptcha.configure do |config|
  config.public_key  = '6Lc5uOgSAAAAALDvNoF85UGXsHWdSs3qA81fSA0u'
  config.private_key = '6Lc5uOgSAAAAAOp-AFO_s_fkyFJpAsoOyNmwW_db'
end
  config.assets.debug = true
     config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => true,
    :address => 'smtp.gmail.com',
    :port => 587,
    :authentication => :plain,
    :domain => 'gmail.com',
    :user_name => 'yosistemasucb@gmail.com',
    :password => 'tddds2013',
}
end