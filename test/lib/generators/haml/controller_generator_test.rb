require 'test_helper'
require 'lib/generators/haml/testing_helper'

class Haml::Generators::ControllerGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Rails::Generators::ControllerGenerator
  arguments %w(Account foo bar --template-engine haml)

  setup :prepare_destination
  setup :copy_routes

  test "should invoke template engine" do
    run_generator
    assert_file "app/views/account/foo.html.haml", %r(app/views/account/foo\.html\.haml)
    assert_file "app/views/account/bar.html.haml", %r(app/views/account/bar\.html\.haml)
  end
end
