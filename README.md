# Haml-rails

Haml-rails provides Haml generators for Rails 3. It also enables Haml as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah.

To use it, add this line to your Gemfile:

    gem "haml-rails"

This ensures that:
  * Any time you generate a controller or scaffold, you'll get Haml templates (instead of ERB)
  * When your Rails application loads, Haml will be loaded and initialized automatically
  * Haml templates will be respected by the view template cache digestor

Pretty fancy, eh? The modern world is just so amazing.

### Contributors

Haml generators originally from [rails3-generators](http://github.com/indirect/rails3-generators), and written by José Valim, André Arko, Paul Barry, Anuj Dutta, Louis T, and Chris Rhoden. Tests originally written by Louis T.

### Code Status

[![Build Status](https://travis-ci.org/indirect/haml-rails.png)](https://travis-ci.org/indirect/haml-rails)

### License

Ruby license or MIT license, take your pick.
