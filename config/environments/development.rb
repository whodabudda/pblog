Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  #in config/environments/production.rb
  #config.to_prepare { Devise::SessionsController.force_ssl }
  #config.to_prepare { Devise::RegistrationsController.force_ssl }
  #config.to_prepare { Devise::PasswordsController.force_ssl }
  #
  config.log_level = :debug
  ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
  #config.action_mailer.logger.level = :warn   #debug produces massive log if an image is in the mail message
  #debug produces massive log if an image is in the mail message
  config.action_mailer.logger = ActiveSupport::Logger.new("log/mailer.log")
  config.action_mailer.logger.level = ActiveSupport::Logger::Severity::INFO

  #ssl controled through the apache proxy server.  This setting for rails seems not to work.
  #config.force_ssl = true 
  # ppk added for mailcatcher
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
  # end ppk mailcatcher

  # dev setup for mail
  config.action_mailer.default_url_options = { host: 'localhost.com'}
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  #ppk added for rails 6.x
  config.hosts << "localhost.com"
  config.hosts << "localstage"
  config.public_file_server.enabled = true
  config.mail_delivery_queue_option = 'deliver_now'
end
