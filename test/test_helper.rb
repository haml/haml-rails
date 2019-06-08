require 'rubygems'
require 'minitest/autorun'
require 'action_pack'
require 'action_controller'
require 'action_view'
require 'rails'
require 'rails/generators'
require 'rails/generators/test_case'
Bundler.require(:default)

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
  config.eager_load = false
end

module Rails
  def self.root
    @root ||= Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails')))
  end
end

TestApp.initialize!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

module Haml
  module Rails
    module GeneratorTestHelpers
      private

      def copy_routes
        routes = File.join(File.dirname(__FILE__), 'fixtures', 'routes.rb')
        destination = File.join(::Rails.root, "config")
        FileUtils.mkdir_p(destination)
        FileUtils.cp File.expand_path(routes), File.expand_path(destination)
      end
    end
  end
end

::Rails::Generators::TestCase.include Haml::Rails::GeneratorTestHelpers

# Remove tmp directory when test suite is completed
MiniTest.after_run do
  tmp_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp'))
  FileUtils.rm_r(tmp_dir)
end
