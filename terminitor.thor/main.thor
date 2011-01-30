class Terminitor < Thor
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
 
  desc 'rails NAME', "Creates a terminitor config for Rails"
  def rails(name)
    common(name)
    template("templates/rails.tt", @filename)
  end
 
  desc 'jquery NAME', "Creates a terminitor config for jQuery"
  def jquery(name)
    common(name)
    template("templates/jquery.tt", @filename)
  end

  private
  def common(name)
    @dir = Thor::Util.snake_case(name)
    @filename = "~/.terminitor/#{@dir}.term"
    @name = name.capitalize
    puts "Creating new terminior config #{@filename}"
  end
end
