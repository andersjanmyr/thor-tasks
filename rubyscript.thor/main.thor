class Rubyscript < Thor
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  desc 'generate NAME', 'Generate a new script'
  method_option :opts, :type => :hash, :default => {}, :aliases => %w(-o)
  def generate(name)
    puts options[:opts]
    template("templates/rubyscript.tt", "#{name}.rb")       
  end

  no_tasks do
    def opts
      options[:opts]
    end
  end
  
end
