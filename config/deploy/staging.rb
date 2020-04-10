# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "localhost", user: "whodabudda", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}
set :application, "pbstage"
set :repo_url, "git@github.com:whodabudda/pblog.git"
set :branch, 'one-col-blog'

set :deploy_to_localhost, ENV.fetch("USE_LOCALHOST",false)
#
#configure role names in an array, otherwise there is no way to
#retrieve just the role names once they are converted to server properties
#
set :my_roles, %w{app}


# Default deploy_to directory is /var/www/my_app_name
if fetch(:deploy_to_localhost)
	set :deploy_to, "/home/whodabudda/sites/#{fetch(:application)}"
	server "localhost", user: "whodabudda", roles: fetch(:my_roles)
else
	set :deploy_to, "/home/whodabudda/#{fetch(:application)}"
	server "whodabudda.com", user: "whodabudda", roles: fetch(:my_roles), port: 7822
end


#
# utility tasks for dumping out data, or halting execution at some flow point
# or performing custom task
#
namespace :deploy do

	ask(:continue,false)
#	before :updating, :exit
#	after :starting, :exit
#	before :updating , :exit
	before :starting, :props  #show some info
	after :starting, :check_continue do
		if !fetch(:continue)
			puts "will exit immediately"
			exit
		end
		puts "continuing...."
	end
	before :finishing, :copy_shared_files
end

# Default value for keep_releases is 5
# set :keep_releases, 5
set :rvm1_type, :user
set :rvm1_ruby_version, '2.6.1@r6'
#set :rvm1_custom_path, '/usr/share/rvm'
#set :rvm1_map_bins, %w{rake gem bundle ruby}

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{whodabudda@localhost.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
