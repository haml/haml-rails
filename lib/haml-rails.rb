module Haml
  module Rails
    class Railtie < ::Rails::Railtie
      config.generators.template_engine :haml
    end
  end
end
