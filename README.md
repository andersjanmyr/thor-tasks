## Thor Tasks

Contains a bunch of generators written in thor. What is a generator
without a generator generator. **Gen** is then name of this one.

### Gen

Gen is a generator generator. It is used to create new Thor
generators. It generates them and sets up rspec for simple testing.

    $ thor help gen
    Tasks:
      thor gen:group NAME   # Generate a "class Name < Thor::Group generator
      thor gen:help [TASK]  # Describe available tasks or one specific task
      thor gen:single NAME  # Generate a "class Name < Thor" generator


#### gen:group

    $ thor help gen:group
    Usage:
      thor gen:group NAME

    Options:
      -t, [--tasks=one two three]  # An list of tasks, generates one method per task


##### Example
    $ thor gen:group group_task -t do_one do_two
          create  group_task.thor/main.thor
          create  group_task.thor/templates/sample.txt.tt
          create  group_task.thor/spec
          create  group_task.thor/spec/integration/main_spec.rb
          create  group_task.thor/spec/spec_helper.rb


#### gen:single

    $ thor help gen:single
    Usage:
      thor gen:single NAME

    Options:
      -t, [--tasks=one two three]  # An list of tasks, generates one method per task

    Generate a "class Name < Thor" generator


##### Example

    $ thor gen:single new_task -t do_something
          create  new_task.thor/main.thor
          create  new_task.thor/templates/do_something/sample.txt.tt
          create  new_task.thor/spec
          create  new_task.thor/spec/integration/main_spec.rb
          create  new_task.thor/spec/spec_helper.rb


#### Testing

To simplify testing the generated `spec_helper.rb` contains two helper
methods `thor` and `file`. 

`thor` takes a string of arguments and runs Thor with them.

`file` takes a filename as parameter and returns a File object that is
enhanced with two methods, `exist?` and `contents`, allowing us to write
specs like this:


    it 'should create the expected files' do
      thor('terminitor rails dummy')
      dummy_file.should exist
    end

    it 'should contain the name' do
      file('dummy/slides/01_intro.md').contents.should match(/# dummy #/)
    end

### Rubyscript

The rubyscript task generates a file that is set up with OptionParser
parsing configured and options for `help`, `verbose`, and `version`.

    $ thor rubyscript:generate new_script
          create  new_script.rb

### Sinatra

The sintra task generates a Sintra project setup with a `Gemfile` for
Bundler and with `sinatra/reloader` configured for development mode.
It is also setup for testing with rspec and rack-test.

There are two ways to call the task:

    $ thor help sinatra
    Tasks:
      thor sinatra:create NAME      # Generate a new sinatra app
      thor sinatra:create_app NAME  # Generate a new sinatra app with class
      thor sinatra:help [TASK]      # Describe available tasks or one specific task


### terminitor

The terminitor task generates a terminitor configuration file for
different kinds of projects. 

    $ thor help terminitor
    Tasks:
      thor terminitor:help [TASK]  # Describe available tasks or one specific task
      thor terminitor:jquery NAME  # Creates a terminitor config for jQuery
      thor terminitor:rails NAME   # Creates a terminitor config for Rails


The jQuery terminitor file sets up terminitor to open two tabs in the
correct directory 

* Livereload, uses RVM to use the system ruby.
* A bash shell


The rails terminitor file sets up terminitor to open five tabs in the
correct directory 

* Spork
* Autotest
* Livereload, uses RVM to use the system ruby.
* A Rails Server
* A bash shell


