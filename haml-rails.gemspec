# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "haml-rails"
  s.version     = "0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["André Arko"]
  s.email       = ["andre@arko.net"]
  s.homepage    = "http://github.com/indirect/haml-rails"
  s.summary     = "let your Gemfile do the configuring"
  s.description = "Haml-rails provides Haml generators for Rails 3. It also enables Haml as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "haml-rails"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'
end