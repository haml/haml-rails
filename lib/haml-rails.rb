require 'haml'
require 'rails'

module Haml
  module Rails
    class Railtie < ::Rails::Railtie
      if ::Rails.version.to_f >= 3.1
        config.app_generators.template_engine :haml
      else
        config.generators.template_engine :haml
      end

      config.before_initialize do
        Haml.init_rails(binding)
        Haml::Template.options[:format] = :html5
      end
    end
  end
end
