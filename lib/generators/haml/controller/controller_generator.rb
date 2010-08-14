require 'generators/haml'
require 'rails/generators/erb/controller/controller_generator'

module Haml
  module Generators
    class ControllerGenerator < Erb::Generators::ControllerGenerator
      extend TemplatePath

      protected

        def handler
          :haml
        end
    end
  end
end
