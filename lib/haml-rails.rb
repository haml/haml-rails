require 'haml'
require 'rails'

module Haml
  module Rails
    class Railtie < ::Rails::Railtie
      if ::Rails.version.to_s >= "3.1"
        config.app_generators.template_engine :haml
      else
        config.generators.template_engine :haml
      end

      config.before_initialize do
        Haml.init_rails(binding)
        Haml::Template.options[:format] = :html5
      end

      initializer 'haml_rails.configure_template_digestor' do
        # Configure cache digests to parse haml view templates
        # when calculating cache keys for view fragments

        ActiveSupport.on_load(:action_view) do
          ActiveSupport.on_load(:after_initialize) do
            begin
              if defined?(CacheDigests::DependencyTracker)
                # 'cache_digests' gem being used (overrides Rails 4 implementation)
                CacheDigests::DependencyTracker.register_tracker :haml, CacheDigests::DependencyTracker::ERBTracker

                if ::Rails.env.development?
                  # recalculate cache digest keys for each request
                  CacheDigests::TemplateDigestor.cache = ActiveSupport::Cache::NullStore.new
                end
              else
                # will only apply if Rails 4, which includes 'action_view/dependency_tracker'
                require 'action_view/dependency_tracker'
                ActionView::DependencyTracker.register_tracker :haml, ActionView::DependencyTracker::ERBTracker
                ActionView::Base.cache_template_loading = false if ::Rails.env.development?
              end
            rescue
              # likely this version of Rails doesn't support dependency tracking
              # so, we can't parse haml templates without 'cache_digests' gem anyway :)
            end
          end
        end
      end
    end
  end
end
