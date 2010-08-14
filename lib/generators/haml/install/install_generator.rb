require 'generators/haml'

module Haml
  module Generators
    class InstallGenerator < Rails::Generators::Base
      extend TemplatePath

      def copy_initializer_files
        template "config/initializers/haml.rb.tt", "config/initializers/haml.rb"
      end

    end
  end
end
