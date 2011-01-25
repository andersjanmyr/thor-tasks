class Showoff < Thor::Group
  include Thor::Actions
  desc 'Generates a Showoff presentation'
  argument :name, :desc => 'The name and title of the presentation'
  class_option :sub_title, :aliases => "-s", :desc => 'The sub title is displayed below the NAME'
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

  def sub_title
    options[:sub_title]
  end
  
end
