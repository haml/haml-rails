require 'test_helper'
require 'rails/generators/rails/controller/controller_generator'
require 'generators/haml/controller/controller_generator'

class Haml::Generators::ControllerGeneratorTest < Rails::Generators::TestCase
  destination Rails.root
  tests Rails::Generators::ControllerGenerator

  setup :prepare_destination
  setup :copy_routes

  arguments %w(Account foo bar --template-engine haml)

  test "should invoke haml engine" do
    run_generator
    assert_file "app/views/account/foo.html.haml"
    assert_file "app/views/account/bar.html.haml"
  end
end
