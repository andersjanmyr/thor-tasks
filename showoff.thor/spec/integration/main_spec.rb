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
    
    ['abstract.md', 'jayway.css', 'showoff.json', 
     'images/jay.png', 'images/jay_small.png',
     'slides/01_intro.md', 'slides/02_code.md', 
     'slides/99_summary.md'].each do |name|
       filename = "dummy/#{name}"
       it "should create #{filename}" do
         file(filename).should exist
       end
     end
     
   context 'abstract.md' do
      it 'should contain title' do
        file('dummy/abstract.md').contents.should match(/## dummy/)
      end
    end

    context 'showoff.json' do
      it 'should contain the name' do
        file('dummy/showoff.json').contents.should match(/"dummy"/)
      end
    end
    
    context '01_intro.md' do
      it 'should contain the name' do
        file('dummy/slides/01_intro.md').contents.should match(/# dummy #/)
      end

      it 'should not contain sub_title' do
        file('dummy/slides/01_intro.md').contents.should_not match(/sub_title/)
      end
    end
    
    
    
    
  end
end
