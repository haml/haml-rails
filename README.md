# Haml-rails
[![Build Status](https://travis-ci.org/haml/haml-rails.svg)](https://travis-ci.org/haml/haml-rails)

Haml-rails provides Haml generators for Rails 5. It also enables Haml as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah.

To use it, add this line to your Gemfile:

    gem "haml-rails", "~> 2.0"

This ensures that:

  * Any time you generate a resource, view, or mailer, you'll get Haml templates (instead of ERB)
  * When your Rails application loads, Haml will be loaded and initialized automatically
  * Haml templates will be respected by the view template cache digestor

Pretty fancy, eh? The modern world is just so amazing.

### Converting Rails application layout file to haml format

Once Haml-rails is installed on the Rails application,
you can convert the erb layout file, `app/views/layouts/application.html.erb`
to `app/views/layouts/application.html.haml` using this command:

    $ rails generate haml:application_layout convert

After the application layout file is converted successfully,
make sure to delete `app/views/layouts/application.html.erb`, so Rails can
start using `app/views/layouts/application.html.haml` instead.

### Converting all .erb views to haml format

If you want to convert all of your .erb views into .haml, you can do so using the following command:

    $ rails haml:erb2haml

If you already have .haml files for one or more of the .erb files, the rake task will give you the option of either
replacing these .haml files or leaving them in place.

Once the task is complete, you will have the option of deleting the original .erb files. Unless you are under
version control, it is recommended that you decline this option.  If you are running in a script, you can use
an environment variable to answer this question.

    $ HAML_RAILS_DELETE_ERB=true rails haml:erb2haml

Running the above will not prompt for the question and will delete the original .erb files.  Setting this value to
false will also not prompt, however, will leave the .erb files intact.

### Older versions of Rails

The current version of Haml-rails requires Rails 5.1 or later.

Haml-rails version 1.0.0 is the last version to support Rails 4. To use it, add this line to your Gemfile:

    gem "haml-rails", "~> 1.0.0"

For Rails 3, use haml-rails version 0.4 by adding this line to your Gemfile instead:

    gem "haml-rails", "~> 0.4.0"

### Contributors

Haml generators originally from [rails3-generators](http://github.com/indirect/rails3-generators), and written by José Valim, André Arko, Paul Barry, Anuj Dutta, Louis T, and Chris Rhoden. Tests originally written by Louis T.

### License

Ruby license or MIT license, take your pick.
