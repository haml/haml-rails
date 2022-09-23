# -*- encoding: utf-8 -*-
require File.expand_path("../lib/haml-rails/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "haml-rails"
  s.version     = Haml::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["André Arko"]
  s.email       = ["andre@arko.net"]
  s.homepage    = "https://github.com/haml/haml-rails"
  s.summary     = "let your Gemfile do the configuring"
  s.description = "Haml-rails provides Haml generators for Rails 5. It also enables Haml as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah."
  s.licenses    = ["MIT"]

  s.required_rubygems_version = ">= 2.0.0"
  s.required_ruby_version     = ">= 2.3.0"

  s.add_dependency "haml",          [">= 4.0.6"]
  s.add_dependency "activesupport", [">= 5.1"]
  s.add_dependency "actionpack",    [">= 5.1"]
  s.add_dependency "railties",      [">= 5.1"]
  
  s.add_development_dependency "html2haml", [">= 1.0.1"]
  s.add_development_dependency "rails",   [">= 5.1"]
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency 'appraisal'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'
end
