source 'https://rubygems.org'

#
#06/08/2019 ppk added gems for notifications
#
gem 'webpush'               # web notifications
gem 'serviceworker-rails'   # for serviceworker cacheing.  Not doing this yet.
gem 'browser'               # get browser name

gem 'webpacker' , :git => "git://github.com/rails/webpacker.git"            # new with rails 6.x
gem 'rubocop'               # check code integrity
gem 'redis'		    #this is the redis ruby client ie: redis.rb on github
gem 'redis-namespace'	    #needed to namespace the sidekiq instances
gem 'sidekiq'		    #sidekiq can run in systemd user space. redis runs in system space
gem 'sidekiq-status'	    #separate gem to keep track of sidekiq jobs
#
#11/19/2018 ppk added comments
#
#gems added by ppk
#
#devise for user login
#
gem "devise", ">= 4.7.1"
#gem 'devise'
#
#bootstrap is twitter library for organization of content in views
#
#gem 'bootstrap', '~> 4.3.1'
gem 'mini_racer'
#
#tether needed for bootstrap
#
#source 'https://rails-assets.org' do
#  gem 'rails-assets-tether', '>= 1.3.3'
#end
#
#carrierwave and mini_magick for file uploads, as in image files for user profiles
#ppk 09/09/2019 force minimagic upversion due to security issue
#
gem 'carrierwave'
gem "mini_magick", ">= 4.9.4"


#
#Three gems for providing editors with the ability to embed images in the content
#
#gem 'ckeditor_rails'
#ppk removed for webpack: gem 'jquery-oembed-rails'
#gem 'tinymce-rails'

group :development do
    gem 'capistrano'
    gem 'capistrano-rvm'
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
#gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
#ppk removed for webpack: gem 'sass-rails', '~> 5.0'
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
#ppk removed for webpack: gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#ppk removed for webpack: gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
#ppk removed for webpack: gem 'jquery-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "actionview", ">= 5.0.7.2"
gem "activejob", ">= 5.0.7.1"




