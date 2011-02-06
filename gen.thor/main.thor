class Gen < Thor
  include Thor::Actions
  attr_reader :name
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  desc 'single NAME', 'Generate a "class Name < Thor" generator'
  method_option :tasks, :type => :array, :default => %w(), :aliases => %w(-t),
    :desc => 'An list of tasks, generates one method and template per task'
  def single(name)
    @name = name
    template("templates/single.tt", "#{name}.thor/main.thor") 
    tasks.each do |task|
      template("templates/template.tt", "#{name}.thor/templates/#{task}/sample.txt.tt")       
    end
    directory("templates/spec", "#{name}.thor/spec")
  end

  desc 'group NAME', 'Generate a "class Name < Thor::Group generator'
  method_option :tasks, :type => :array, :default => %w(), :aliases => %w(-t),
    :desc => 'An list of tasks, generates one method and template per task'

  def group(name)
    @name = name
    template("templates/group.tt", "#{name}.thor/main.thor")    
    template("templates/template.tt", "#{name}.thor/templates/sample.txt.tt")       
    directory("templates/spec", "#{name}.thor/spec")
  end

  private

  def task
    options[:task]
  end

  def tasks
    options[:tasks]
  end
  
  
end
