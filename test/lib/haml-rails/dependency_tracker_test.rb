# frozen_string_literal: true

require 'test_helper'
require 'action_view/dependency_tracker'

# Touch ActionView::Base so haml-rails' `on_load(:action_view)` hook fires and
# registers the :haml tracker. In a real app this happens the first time a view
# renders; a bare tracker test never renders one, so we force the load here.
ActionView::Base

# Regression test for cache dependency detection on Haml templates.
#
# Rails 8.1 tightened ERBTracker to only match render calls inside ERB
# `<% %>` tags, which stopped it from seeing Haml's `= render` and silently
# broke fragment cache busting. haml-rails now registers RubyTracker (which
# compiles the template to Ruby before scanning) where it is available.
#
# This test asserts the behavior that actually matters: given a Haml template
# that renders partials, the registered tracker reports those partials as
# dependencies.
class DependencyTrackerTest < Minitest::Test
  # Minimal stand-in for an ActionView::Template that exposes just what the
  # dependency trackers touch: the Haml handler and the source.
  class FakeTemplate
    attr_reader :source, :handler

    def initialize(source)
      @source = source
      @handler = ActionView::Template.handler_for_extension(:haml)
    end

    def identifier
      'fake/template'
    end

    def type
      'text/html'
    end

    def format
      :html
    end
  end

  def find_dependencies(source)
    ActionView::DependencyTracker.find_dependencies('things/index', FakeTemplate.new(source), nil)
  end

  def test_detects_a_rendered_partial
    assert_includes find_dependencies(%(= render "shared/menu")), 'shared/menu'
  end

  def test_detects_a_partial_rendered_with_explicit_option
    assert_includes find_dependencies(%(= render partial: "posts/post")), 'posts/post'
  end

  def test_detects_an_explicit_dependency_comment
    assert_includes find_dependencies(%(-# Template Dependency: shared/menu)), 'shared/menu'
  end
end
