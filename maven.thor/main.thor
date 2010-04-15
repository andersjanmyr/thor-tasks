#
# Generates maven layouts
# usage: thor maven -h
#
class Maven < Thor::Group
  include Thor::Actions
  argument :name
  class_option :package, :default => 'com.jayway', 
    :desc => 'The package will be prepended before the NAME'
  class_option :type, :default => :scala, 
    :desc => 'Type of project (currently, scala )'
  class_option :layout, :default => :boner, 
    :desc => 'Layout boner flattens the package directory'
  class_option :buildfile, :default => :buildfile,
    :desc => 'Buildfile to use (currently, buildfile and pom.xml)'
  class_option :test, :default => :scalatest,
    :desc => 'Testing framework to use (currently, scalatest)'
  
  
  def self.source_root
    File.dirname(__FILE__)
  end
    
  def generate_src_file
    template("templates/#{type}/app.tt", "#{name}/src/main/#{type}/#{package_dir}/App.scala")    
  end

  def generate_test_file
    template("templates/#{type}/#{test}.tt", "#{name}/src/test/#{type}/#{package_dir}/AppTest.scala")    
  end
  
  def generate_buildfile
    template("templates/#{type}/#{buildfile}.tt", "#{name}/#{buildfile}")        
  end
  
  no_tasks do
    def package
      "#{options[:package]}"
    end

    def package_dir
      if options[:layout] == :boner
        name
      else
        "#{options[:package].gsub('.', '/')}/#{name}"
      end
    end

    def type
      options[:type]
    end

    def test
      options[:test]
    end

    def buildfile
      options[:buildfile]
    end
  end
end


