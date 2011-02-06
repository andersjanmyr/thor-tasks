require 'rspec'
require 'stringio'
require 'fileutils'

RSpec.configure do |config|
  include FileUtils

  def capture(*streams)
    streams.map! { |stream| stream.to_s }
    begin
      result = StringIO.new
      streams.each { |stream| eval "$#{stream} = result" }
      yield
    ensure
      streams.each { |stream| eval("$#{stream} = #{stream.upcase}") }
    end
    result.string
  end

  def sandbox
    File.join(File.dirname(__FILE__), 'sandbox')
  end

  def run(command)
    mkdir_p sandbox
    cd(sandbox) do
      system("#{command}")
    end
  end
  
  def thor(args)
    run("thor #{args}")
  end

  def clean
    rm_rf sandbox
  end

  # Creates a file object from a filename.
  # If the filename is absolute, the file references the actual file.
  # If the filename is relative, a file is referenced to a sandboxed
  # file.
  def file(name)
    if name.start_with?('/')
      File.new(name)
    elsif name.start_with?('~')
      File.new(name.gsub('~', "#{ENV['HOME']}"))
    else
      File.new(File.join(sandbox, name))
    end
  end
end

module FileExt
  # Checks if a file exists.
  def exist?
    File.exist?(path)
  end

  # The contents of the file.
  def contents
    read
  end
end

class File
  include FileExt
end
