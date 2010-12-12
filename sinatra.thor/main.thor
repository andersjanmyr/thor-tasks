class Sinatra < Thor
  include Thor::Actions
  attr_reader :name
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  desc 'create NAME', 'Generate a new sinatra app'
  method_option :opt, :type => :string, :default => 'def', :aliases => %w(-o)
  def create(name)
    @name = name
    puts "Creating new sinatra app"
    template("templates/config.ru.tt", "#{name}/app.rb")       
    template("templates/config.ru.tt", "#{name}/config.ru")       
    template("templates/Gemfile.tt", "#{name}/Gemfile")       
  end
  
end
