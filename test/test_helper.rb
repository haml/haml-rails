# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'logger'
require 'minitest/autorun'
require 'action_pack'
require 'action_controller'
require 'action_view'
require 'active_model'
require 'rails'
require 'rails/generators'
require 'rails/generators/test_case'
Bundler.require(:default)

class TestApp < Rails::Application
  config.root = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails')))
  config.eager_load = false
end

require 'action_controller/railtie'
require 'action_view/railtie'

TestApp.initialize!

Rails.application.routes.draw do
  resources :people
end

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

class Person
  include ActiveModel::Model

  attr_accessor :id, :name

  def initialize(id, name)
    @id, @name = id, name
  end

  def to_param
    {id: @id}
  end
end

class ApplicationController < ActionController::Base
end

# Remove tmp directory when test suite is completed
Minitest.after_run do
  tmp_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp'))
  FileUtils.rm_r(tmp_dir)
end
