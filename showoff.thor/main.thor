class Showoff < Thor::Group
  include Thor::Actions
  argument :name, :desc => 'The name and title of the presentation'
  class_option :sub_title, :aliases => "-s", :desc => 'The sub title is displayed below the NAME'


  def self.source_root
    File.dirname(__FILE__)
  end
 
  def files
    directory('files', "#{dir}")
  end

  def showoff_json
    template("templates/showoff.json.erb", "#{dir}/showoff.json")       
  end
  
  def slides
    template("templates/slides/01_intro.md.erb", "#{dir}/slides/01.intro.md")       
  end

  def abstract
    template('templates/abstract.md.erb', "#{dir}/abstract.md")
  end

private
  def dir
    name.downcase.gsub(' ', '_')
  end

  def sub_title
    options[:sub_title]
  end
  
end
