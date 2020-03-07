#require 'sidekiq'
#require 'sidekiq-status'

#Sidekiq.configure_client do |config|
#  config.client_middleware do |chain|
#    chain.add Sidekiq::Status::ClientMiddleware
#  end
#  config.redis = { :namespace => 'pblog', :url => 'redis://127.0.0.1:6379/1' }
#end

Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'pblog', :url => 'redis://127.0.0.1:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'pblog', :url => 'redis://127.0.0.1:6379/0' }
end

