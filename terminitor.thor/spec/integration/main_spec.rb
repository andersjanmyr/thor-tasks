require File.join(File.dirname(__FILE__), '../spec_helper')

describe 'thor terminitor' do
 
  let(:dummy_file) {file('~/.terminitor/dummy.term')}

  describe 'running rails with NAME argument' do
   
    it 'should create the expected files' do
      thor('terminitor rails dummy')
      dummy_file.should exist
    end
  end
  
  describe 'running jquery with NAME argument' do
    it 'should create the expected files' do
      thor('terminitor jquery dummy')
      dummy_file.should exist
    end

  end

  after :each do
    rm_rf dummy_file
  end
  
end
