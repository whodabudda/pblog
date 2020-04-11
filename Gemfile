source 'https://rubygems.org'

gem 'webpush'               # web notifications
gem 'serviceworker-rails'   # for serviceworker cacheing.  Not doing this yet.
gem 'browser'               # get browser name

#
#getting the master branch of webpacker because it has fixes not yet packaged
#
#gem 'webpacker' , :git => "git://github.com/rails/webpacker.git" # new with rails 6.x
gem 'webpacker' , '~> 5.0'
gem 'rubocop'               # check code integrity
gem 'redis'		    #this is the redis ruby client ie: redis.rb on github
gem 'redis-namespace'	    #needed to namespace the sidekiq instances
gem 'sidekiq'		    #sidekiq can run in systemd user space. redis runs in system space
gem 'sidekiq-status'	    #separate gem to keep track of sidekiq jobs

#
#devise for user login
#
gem "devise", ">= 4.7.1"
gem 'mini_racer'

#carrierwave and mini_magick for file uploads, as in image files for user profiles
#ppk 09/09/2019 force minimagic upversion due to security issue
#
gem 'carrierwave'
gem "mini_magick", ">= 4.9.4"

group :development do
    gem 'capistrano'
    gem 'rvm1-capistrano3', require: false
    gem 'capistrano-rails'
    gem 'capistrano3-puma'
    gem 'capistrano-bundler', '>= 1.1.0'
    gem 'capistrano-faster-assets'
end
gem 'social-share-button'
gem 'analytics-ruby', require: "segment"
######################## end of gems added by ppk

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'
# Use sqlite3 as the database for Active Record
gem 'mysql2'
gem 'sqlite3'

# Use Puma as the app server
# security issue requires > 3.12.2
gem "puma", ">= 3.12.2"

# Use SCSS for stylesheets
gem 'sassc-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background. 
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "actionview", ">= 5.0.7.2"
gem "activejob", ">= 5.0.7.1"




