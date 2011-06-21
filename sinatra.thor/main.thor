class Sinatra < Thor
  include Thor::Actions
  attr_reader :name
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  desc 'simple NAME', 'Generate a new simple app'
  method_option :app, :type => :boolean, :default => false, :aliases => %w(-a)
  def simple(name)
    setup name
    puts "Creating new Sinatra simple #{@name}"
    common
    directory('templates/simple', @target)
  end

  desc 'app NAME', 'Generate a new app with class'
  def app(name) 
    setup name
    puts "Creating new Sinatra App #{@name}"
    common
    template("templates/class/lib/app.rb.tt", "#{@target}/lib/#{@name}.rb")
    template("templates/class/lib/version.rb.tt", "#{@target}/lib/#{@name}/version.rb")
    template("templates/class/spec/spec_helper.rb.tt", "#{@target}/spec/spec_helper.rb")
    template("templates/class/spec/support/struct_matcher.rb", "#{@target}/spec/support/struct_matcher.rb")
    template("templates/class/spec/app/app_spec.rb.tt", "#{@target}/spec/app/#{@name}_spec.rb")
    template("templates/class/config.ru.tt", File.join(@target, 'config.ru'))
    init_git 
  end

  private
  
  def setup name
    @name = name
    @target = File.join(Dir.pwd, name)
    @constant_name = name.split('_').map{|p| p.capitalize}.join
    @constant_name = @constant_name.split('-').map{|q| q.capitalize}.join('::') if @constant_name =~ /-/
    @constant_array = @constant_name.split('::')
  end

  def common
    template("templates/common/Gemfile.tt", File.join(@target, "Gemfile"))
    template("templates/common/Rakefile.tt", File.join(@target, "Rakefile"))
    template("templates/common/gitignore.tt", File.join(@target, ".gitignore"))
    template("templates/common/newgem.gemspec.tt", File.join(@target, "#{@name}.gemspec"))
    bin_file = File.join(@target, 'bin', @name)
    template("templates/common/bin/cli.tt", bin_file)
    chmod(bin_file, 0744)
  end

  def init_git
    puts "Initializating git repo in #{@name}"
    Dir.chdir(@target) { `git init`; `git add .` }
  end
  
end
