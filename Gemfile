source "https://rubygems.org"
git_source(:github) { |name| "https://github.com/#{name}.git" }

gem "rails", "= 6.0.3.4"
gem "will_paginate"

gem "http",                github: "feedbin/http",                branch: "feedbin"
gem "carrierwave_direct",  github: "feedbin/carrierwave_direct",  ref: "a0bc323"
gem "dalli",               github: "feedbin/dalli",               branch: "feedbin"
gem "feedjira",            github: "feedbin/feedjira",            branch: "f2"
gem "feedkit",             github: "feedbin/feedkit",             branch: "master"
gem "grocer-pushpackager", github: "feedbin/grocer-pushpackager", ref: "6b01b4e", require: "grocer/pushpackager"
gem "html-pipeline",       github: "feedbin/html-pipeline",       ref: "1e77ecf"
gem "html_diff",           github: "feedbin/html_diff",           ref: "013e1bb"
gem "opml_saw",            github: "feedbin/opml_saw",            ref: "61d8c2d"
gem "elasticsearch-model", github: "feedbin/elasticsearch-rails", branch: "2.x"
gem "twitter",             github: "feedbin/twitter",             branch: "feedbin"
gem "oauth",               github: "feedbin/oauth-ruby",          branch: "feedbin"

gem "activerecord-import"
gem "addressable", require: "addressable/uri"
gem "apnotic"
gem "autoprefixer-rails"
gem "bcrypt"
gem "bcrypt-ruby"
gem "bootsnap", require: false
gem "carrierwave"
gem "clockwork"
gem "coffee-rails"
gem "connection_pool"
gem "curb"
gem "dotenv-rails"
gem "elasticsearch", "~> 2.0"
gem "evernote_oauth"
gem "fog-aws"
gem "foreman"
gem "honeybadger"
gem "htmlentities"
gem "httparty"
gem "jbuilder"
gem "jquery-rails"
gem "librato-rails", "~> 1.4.2"
gem "lograge"
gem "mini_racer"
gem "net-http-persistent"
gem "pg"
gem "premailer-rails"
gem "rack-attack"
gem "rails-controller-testing"
gem "raindrops"
gem "redcarpet"
gem "redis"
gem "responders"
gem "reverse_markdown"
gem "rmagick", require: false
gem "rubyzip"
gem "sanitize"
gem "sass-rails"
gem "sidekiq"
gem "stripe", "~> 4.24.0"
gem "stripe_event"
gem "twitter-text"
gem "uglifier"
gem "unicode-emoji"
gem "unicorn"

group :development do
  gem "benchmark-ips"
  gem "better_errors"
  gem "binding_of_caller"
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "htmlbeautifier"
  gem "listen"
  gem "silencer"
  gem "spring"
end

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara"
  gem "coveralls", require: false
  gem "faker"
  gem "minitest"
  gem "minitest-stub-const"
  gem "minitest-stub_any_instance"
  gem "puma"
  gem "selenium-webdriver"
  gem "standard"
  gem "stripe-ruby-mock", "= 2.5.0", require: "stripe_mock"
  gem "webmock", "= 3.8.0"
end
