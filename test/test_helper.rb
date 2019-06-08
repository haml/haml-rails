require 'rubygems'
require 'minitest/autorun'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails'))
  end
end

# Call configure to load the settings from
# Rails.application.config.generators to Rails::Generators
Rails.application.load_generators

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

def copy_routes
  routes = File.join(File.dirname(__FILE__), 'fixtures', 'routes.rb')
  destination = File.join(Rails.root, "config")
  FileUtils.mkdir_p(destination)
  FileUtils.cp File.expand_path(routes), File.expand_path(destination)
end

def path_prefix(name)
  case name
  when :rails
    'rails/generators'
  else
    'generators'
  end
end

{rails: ['scaffold', 'controller', 'mailer'], haml: ['scaffold', 'controller', 'mailer']}.each do |name, generators|
  generators.each do |generator_name|
    if name.to_s == 'rails' && generator_name.to_s == 'mailer'
      require File.join(path_prefix(name), generator_name.to_s, "#{generator_name}_generator")
    else
      require File.join(path_prefix(name), name.to_s, generator_name.to_s, "#{generator_name}_generator")
    end
  end
end

# Remove tmp directory when test suite is completed
MiniTest.after_run do
  tmp_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp'))
  FileUtils.rm_r(tmp_dir)
end
