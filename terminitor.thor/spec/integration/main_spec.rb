require File.join(File.dirname(__FILE__), '../spec_helper')

describe 'thor terminitor' do
  
  describe 'running with NAME argument' do
   
    it 'should create the expected files' do
      thor('terminitor rails dummy')
      File.new('~/.terminitor/dummy.term').should exist
    end

    it 'should create the expected files' do
      thor('terminitor jquery dummy')
      File.new('~/.terminitor/dummy.term').should exist
    end

    after do
      rm_rf '~/.terminitor/dummy.term'
    end
  
  end
end
