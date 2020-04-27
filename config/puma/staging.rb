# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
# preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
# on_worker_boot do
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

#BEGIN custom setup ################################################################
# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
#
port        ENV.fetch("PORT") { 3005 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "staging" }

#
# We sometimes deploy the stage  to localhost machine (currently 'whodabudda-Aspire-E5-575G'),
# which is linked to dropbox  through the 'sites' path.  
# Thus, the path on production machine will be different from the path on the localhost machine.
# If the env variable is set, it overrides the default.
#
#if %x[ hostname].include?("Aspire") 
#	directory ENV.fetch("STAGE_PUMA_ROOT") { "/home/whodabudda/sites/pbstage" }
#else
#	directory ENV.fetch("STAGE_PUMA_ROOT") { "/home/whodabudda/pbstage" }
#end

#
# from:  https://github.com/puma/puma/blob/master/lib/puma/dsl.rb
# Redirect STDOUT and STDERR to files specified. The +append+ parameter
# specifies whether the output is appended, the default is +false+.
#
# @example
#   stdout_redirect '/app/lolcat/log/stdout', '/app/lolcat/log/stderr'
# @example
#   stdout_redirect '/app/lolcat/log/stdout', '/app/lolcat/log/stderr', true
#stdout_redirect '#{directory}/current/log/puma_access.log', '#{directory}/current/log/puma_error.log', true

