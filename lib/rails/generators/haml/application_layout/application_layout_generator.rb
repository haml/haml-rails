require 'rails'
require 'shellwords'

module Haml
  module Generators
    class ApplicationLayoutGenerator < ::Rails::Generators::Base
      HTML_LAYOUT_PATH = 'app/views/layouts/application.html.erb'
      HAML_LAYOUT_PATH = 'app/views/layouts/application.html.haml'

      # Converts existing application.html.erb to haml format,
      # and creates app/views/layouts/application.html.haml
      # with some error checking.
      def convert
        app_layout_from = ::Rails.root.join(HTML_LAYOUT_PATH).to_s
        app_layout_to   = ::Rails.root.join(HAML_LAYOUT_PATH).to_s

        if File.exist?(app_layout_from)

          if !File.exist?(app_layout_to)
            `html2haml #{app_layout_from.shellescape} #{app_layout_to.shellescape}`
            puts "Success! app/views/layouts/application.html.haml is created.\n" \
                 "Please remove the erb file: app/views/layouts/application.html.erb"
          else
            puts "Error! There is a file named app/views/layouts/application.html.haml already."
          end
        else
          puts "Error! There is no file named app/views/layouts/application.html.erb."
        end
      end
    end
  end
end
