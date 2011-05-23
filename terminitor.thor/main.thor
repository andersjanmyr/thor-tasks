class Terminitor < Thor
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
 
  desc 'rails NAME', "Creates a terminitor config for Rails"
  method_option :project_dir, :type => :string, :default => '~/Projects', :aliases => %w(-p),
    :desc => 'The projects directory'
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
    @filename = "~/.config/terminitor/#{@dir}.term"
    @name = name.capitalize
    puts "Creating new terminitor config #{@filename}"
  end

  def project_dir
    options[:project_dir] || '~/Projects'
  end
end
