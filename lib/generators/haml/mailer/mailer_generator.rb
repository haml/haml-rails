require 'generators/haml/controller/controller_generator'

module Haml
  module Generators
    class MailerGenerator < ControllerGenerator
      source_root File.expand_path("../templates", __FILE__)

    protected

      def format
        :text
      end

    end
  end
end
