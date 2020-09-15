require 'rails/generators/erb/mailer/mailer_generator'

module Haml
  module Generators
    class MailerGenerator < Erb::Generators::MailerGenerator
      source_root File.expand_path("../templates", __FILE__)

      protected

      def handler
        :haml
      end
    end
  end
end
