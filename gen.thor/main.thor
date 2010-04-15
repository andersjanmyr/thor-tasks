class Gen < Thor
  include Thor::Actions
  attr_reader :name
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  desc 'single NAME', 'Generate a new single file thor dir'
  method_option :task, :type => :string, :default => 'task', :aliases => %w(-t)
  def single(name)
    @name = name
    template("templates/single.tt", "#{name}.thor/main.thor")       
    template("templates/template.tt", "#{name}.thor/templates/#{task}.tt")       
  end

  desc 'group NAME', 'Generate a new group file thor dir'
  method_option :tasks, :type => :array, :default => %w(one two), :aliases => %w(-t)
  def group(name)
    @name = name
    template("templates/group.tt", "#{name}.thor/main.thor")    
    tasks.each do |task|   
      template("templates/template.tt", "#{name}.thor/templates/#{task}.tt")       
    end
  end

  no_tasks do
    def task
      options[:task]
    end

    def tasks
      options[:tasks]
    end
  end  
  
  
end
