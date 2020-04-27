#require 'sidekiq'
#
# ppk 04/16/2020
# Sidekiq needs to know how to connect with redis.  Also, since the production or development system
# may be running at the same time as stage, need to have a different DB number for redis.
# The SIDEKIQ_REDIS_DB env variable is set in the 'local_env.yml' config file.

Sidekiq.configure_server do |config|
  config.redis = { :namespace => "pblog_#{Rails.env}", :url => "redis://127.0.0.1:6379/#{ENV["SIDEKIQ_REDIS_DB"]}" }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => "pblog_#{Rails.env}", :url => "redis://127.0.0.1:6379/#{ENV["SIDEKIQ_REDIS_DB"]}" }
end

