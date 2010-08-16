module Haml
  module Generators
    module TemplatePath
      def source_root
        File.expand_path("../haml/#{generator_name}/templates", __FILE__)
      end
    end
  end
end
