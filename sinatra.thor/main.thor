class Sinatra < Thor
  include Thor::Actions
  attr_reader :name
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  desc 'create NAME', 'Generate a new sinatra app'
  method_option :app, :type => :boolean, :default => false, :aliases => %w(-a)
  def create(name)
    @dir = Thor::Util.snake_case(name)
    puts "Creating new sinatra app #{@dir}"
    directory('templates/common', @dir)
    directory('templates/simple', @dir)
  end

  desc 'create_app NAME', 'Generate a new sinatra app with class'
  def create_app(name) 
    @dir = Thor::Util.snake_case(name)  
    @name = Thor::Util.camel_case(name)
    puts "Creating new sinatra app, with class #{@dir}"
    directory('templates/common', @dir)
    directory('templates/class', @dir)
  end
  
end
