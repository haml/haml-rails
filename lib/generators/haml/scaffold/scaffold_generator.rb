require 'rails/generators/erb/scaffold/scaffold_generator'

module Haml
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path("../templates", __FILE__)

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def copy_view_files
        available_views.each do |view|
          template_filename = find_template_for_rails_version view
          filename = filename_with_extensions view

          template template_filename, File.join('app/views', controller_file_path, filename)
        end

        template find_template_for_rails_version('partial'), File.join('app/views', controller_file_path, "_#{singular_name}.html.haml")
      end

      hook_for :form_builder, :as => :scaffold

      def copy_form_file
        if options[:form_builder].nil?
          template_filename = find_template_for_rails_version "_form"
          filename = filename_with_extensions "_form"
          template template_filename, File.join("app/views", controller_file_path, filename)
        end
      end

      private

      def available_views
        %w(index edit show new)
      end

      def handler
        :haml
      end

      def find_template_for_rails_version(view)
        find_in_source_paths "#{rails_version}/#{view}.html.haml"
      rescue Thor::Error
        "#{view}.html.haml"
      end

      def rails_version
        @rails_version ||= "#{::Rails::VERSION::MAJOR}_#{::Rails::VERSION::MINOR}"
      end
    end
  end
end
