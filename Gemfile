source 'https://rubygems.org'

# Specify your gem's dependencies in haml-rails.gemspec
gemspec

gem 'html2haml'

if ENV['RAILS_VERSION']
  gem 'rails', "~> #{ENV['RAILS_VERSION']}.0"
else
  gem 'rails'
end

if ENV['RUBY_VERSION'] >= '3.3'
  gem 'mutex_m'
  gem 'base64'
  gem 'bigdecimal'
  gem 'drb'
end
