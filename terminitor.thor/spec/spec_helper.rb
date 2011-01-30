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

  def file(name)
    File.new(File.join(sandbox, name))
  end
end

module FileExt
  def exist?
    File.exist?(path)
  end

  def contents
    read
  end
end

class File
  include FileExt
end
