require 'generators/haml/controller/controller_generator'

module Haml
  module Generators
    class MailerGenerator < ControllerGenerator
    protected
      def format
        :text
      end
    end
  end
end
