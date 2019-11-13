require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# ppk 09/19/2017
# This module was added so that environment variables
# containing values for passwords and keys can be read from secure files.
# For some reason, they must be read from application.rb.  There are
# problems with puma startup if they are read from environments/production.rb
# Furthermore, application.rb cannot be symbolically linked to the capistrano
# shared directory because of the relative read of 'boot', and other errors
# of an obscure nature.
#
module Pblog
  class Application < Rails::Application
  	#config.assets.paths << Rails.root.join('node_modules')
	config.before_configuration do
	  env_file = File.join(Rails.root, '/config/', 'local_env.yml')
	  if File.exists?(env_file)
	  	YAML.load(File.open(env_file)).each do |key, value|
	    		ENV[key.to_s] = value
		end
#	  else
#		Rails.logger.info "Did NOT find #{env_file}"
	  end	
		# PPK 09/09/2019 These paths will be ignored when redirecting the user to last visited page
		# Devise routes need to always be here, so that a redirect loop does not occur
		# after signing in
		config.ignored_paths = %W(/users/sign_in /users/sign_up /users/password /users/sign_out /users/confirm_password /admins/sign_in /admins/sign_up /admins/password /admins/sign_out /admins/confirm_password)
	end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

  end
end
