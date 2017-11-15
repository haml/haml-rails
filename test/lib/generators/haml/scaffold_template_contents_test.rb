# frozen_string_literal: true

require 'test_helper'
require 'rails/generators/rails/scaffold/scaffold_generator'
require 'generators/haml/scaffold/scaffold_generator'
require 'action_controller/test_case'

class Haml::Generators::ScaffoldTemplateContentsTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Rails::Generators::ScaffoldGenerator
  arguments %w(person name)

  setup :prepare_destination
  setup :copy_routes

  def view_context
    @view_context ||= begin
      require Rails.root.join('app/controllers/people_controller')

      controller = PeopleController.new
      controller.set_request!(ActionDispatch::Request.empty)
      controller.request.session = ActionController::TestSession.new

      if controller.lookup_context.respond_to? :append_view_paths
        controller.lookup_context.append_view_paths([Rails.root.join('app/views')])
      else
        controller.lookup_context.view_paths << Rails.root.join('app/views')
      end
      controller.instance_variable_set :@people, []
      controller.instance_variable_set :@person, Person.new(1, 'Person 1')

      controller.view_context
    end
  end

  def assert_html_content_with_erb_version(view, html)
    view_context.lookup_context.handlers = [:erb]
    erb_html = view_context.render(template: "people/#{view}")

    assert_equal scrub(erb_html), scrub(html), "#{view} template result differs from the ERB version"
  end

  def scrub(html)
    html = strip_whitespace html
    strip_authenticity_token! html
    html
  end

  def strip_whitespace(html)
    html_doc = Nokogiri::HTML(html)
    html_doc.xpath('//text()').each do |text_node|
      text_node.remove if text_node.text.strip.empty?
      text_node.content = text_node.text.strip
    end
    html_doc.to_html
  end

  def strip_authenticity_token!(html)
    html.sub!(/(<input type="hidden" name="authenticity_token" value=").*?"/, '\1"')
    html.sub!(/(<input autocomplete="off" name="authenticity_token" type="hidden" value=").*?"/, '\1"')
  end

  test 'should generate a set of templates that are 100% compatible with the original ERB templates' do
    run_generator
    run_generator default_arguments + %w(--template-engine haml)

    %w(index edit new show).each do |view|
      assert_file "app/views/people/#{view}.html.haml"

      view_context.lookup_context.handlers = [:haml]
      haml_html = view_context.render(template: "people/#{view}")

      assert_html_content_with_erb_version view, haml_html
    end
  end
end
