require File.join(File.dirname(__FILE__), '../spec_helper')

describe 'thor showoff' do
  describe 'without arguments' do
    before :all do
      pending
      @result = capture(:stderr) do
        thor('showoff')
      end 
    end
    
    it 'stderr should show missing arguments' do
      pending
      @result.should match(%(arguments 'name'))
    end
    
  end
  
  describe 'running with NAME argument' do
    before :all do
      clean
      thor('showoff dummy')
    end

   
    it 'should create the expected files' do
      file('dummy/abstract.md').should exist
      file('dummy/jayway.css').should exist
      file('dummy/showoff.json').should exist
      file('dummy/images/jay.png').should exist
      file('dummy/images/jay_small.png').should exist
      file('dummy/slides/01_intro.md').should exist
      file('dummy/slides/02_code.md').should exist
      file('dummy/slides/99_summary.md').should exist
    end

    it 'should create "abstract.md" with a title' do
      file('dummy/abstract.md').contents.should match(/## dummy/)
    end
    
    
  end
end
