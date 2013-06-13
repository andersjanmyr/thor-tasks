class Node < Thor::Group
  include Thor::Actions

  desc 'Generates a Node project'
  argument :name, :desc => 'The name of the project'
  class_option :git, :type => :boolean, :aliases => '-g', :desc => 'Initialize a git repository'


  def self.source_root
    File.dirname(__FILE__)
  end
 
  def templates
    directory('templates', "#{dir}")
  end

  def git
    `git init #{dir}` if options[:git]
  end

private
  def dir
    name.downcase.gsub(' ', '_')
  end
  
end
