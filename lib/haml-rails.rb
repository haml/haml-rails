module Haml
  module Rails
    VERSION = "0.1"

    class Railtie < ::Rails::Railtie
      config.generators.template_engine :haml
    end
  end
end
