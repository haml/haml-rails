# Changelog

## 3.1.0

### Features

- Add Rails 8.1 and Ruby 4.0 support.

- Add an authentication generator that produces Haml views for
  `rails generate authentication` (Rails 8+), generating `passwords/new`,
  `passwords/edit`, and `sessions/new` templates.
  [#198](https://github.com/haml/haml-rails/pull/198) (Evan Brooks)

### Bug fixes

- Fix Haml fragment cache dependency detection on Rails 8.1. Rails 8.1 tightened
  its ERB dependency tracker to only match `render` calls inside `<% %>` tags,
  which stopped changes to a Haml partial from busting the cache of templates
  that render it. Haml templates now use the `:ruby` render tracker (available
  since Rails 7.2), which compiles the template before scanning for `render`
  calls. [#200](https://github.com/haml/haml-rails/pull/200),
  fixes [#199](https://github.com/haml/haml-rails/issues/199) (Nick Schimek)

- Add Rails 8.1 scaffold templates. The generated scaffold partial now wraps
  each attribute in a `<div>` (instead of `<p>`) to match Rails 8.1's output.
