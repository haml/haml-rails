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

require 'rails/generators/rails/scaffold/scaffold_generator'
require 'rails/generators/rails/controller/controller_generator'
require 'rails/generators/mailer/mailer_generator'
require 'generators/haml/scaffold/scaffold_generator'
require 'generators/haml/controller/controller_generator'
require 'generators/haml/mailer/mailer_generator'

# Remove tmp directory when test suite is completed
MiniTest.after_run do
  tmp_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp'))
  FileUtils.rm_r(tmp_dir)
end
