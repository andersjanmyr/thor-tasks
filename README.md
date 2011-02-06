## Thor Tasks

Contains a bunch of generators written in thor.

### Gen

**Gen** is a generator generator. It is used to create new Thor
generators. It generates them and sets up rspec for simple testing.

    $ thor help gen
    Tasks:
      thor gen:group NAME   # Generate a "class Name < Thor::Group generator
      thor gen:help [TASK]  # Describe available tasks or one specific task
      thor gen:single NAME  # Generate a "class Name < Thor" generator


    $ thor help gen:group
    Usage:
      thor gen:group NAME

    Options:
      -t, [--tasks=one two three]  # An list of tasks, generates one method and template per task



    $ thor help gen:single
    Usage:
      thor gen:single NAME

    Options:
      -t, [--tasks=one two three]  # An list of tasks, generates one method and template per task

    Generate a "class Name < Thor" generator


