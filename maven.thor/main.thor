class Maven < Thor::Group
  include Thor::Actions
  argument :name
  class_option :package, :default => 'com.jayway'
  class_option :type, :default => :scala
  class_option :layout, :default => :boner
  class_option :buildfile, :default => :buildfile
  class_option :test, :default => :scalatest
  
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
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


