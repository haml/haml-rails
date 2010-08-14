module Haml
  module Generators
    module TemplatePath
      def source_root
        @_haml_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'haml', generator_name, 'templates'))
      end
    end
  end
end
