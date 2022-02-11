source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "jquery-rails"
gem "bootstrap-sass", "~> 3.4", ">= 3.4.1"
gem "rails-i18n"
gem "bcrypt", "~> 3.1", ">= 3.1.13"
gem "config"
gem "rails", "~> 6.0.0.rc1"
gem "ffaker"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "puma", "~> 4.3"
gem "sass-rails", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.4.2", require: false
gem "figaro"
gem "carrierwave"
gem "mini_magick"
gem "i18n-js"

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg", "0.20.0"
  gem "fog"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
