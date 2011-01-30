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
    template("templates/app.rb.tt", "#{@dir}/app.rb")       
    template("templates/config.ru.tt", "#{@dir}/config.ru")       
    template("templates/Gemfile.tt", "#{@dir}/Gemfile")       
    template("templates/livereload.tt", "#{@dir}/.livereload")       
  end

  desc 'create_app NAME', 'Generate a new sinatra app with class'
  def create_app(name) 
    @dir = Thor::Util.snake_case(name)  
    @name = Thor::Util.camel_case(name)
    puts "Creating new sinatra app, with class #{@dir}"
    template("templates/app_with_class.rb.tt", "#{@dir}/#{@dir}.rb")       
    template("templates/config_with_class.ru.tt", "#{@dir}/config.ru")       
    template("templates/Gemfile.tt", "#{@dir}/Gemfile")       
    template("templates/livereload.tt", "#{@dir}/.livereload")       
  end
  
end
