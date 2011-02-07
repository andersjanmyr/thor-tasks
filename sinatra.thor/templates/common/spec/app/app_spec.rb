# encoding: UTF-8
require 'spec_helper'
require 'json'

describe 'Øredev Puzzle Server' do

  def app
    Sinatra::Application
  end

  it "get / presents itself" do
    get '/'
    last_response.should be_ok
    last_response.body.should == 'Øredev Puzzle Server'
  end
  
  describe "get /people" do
    
    it "should get all people " do
      get '/people'
      last_response.should be_ok
      json = JSON.parse(last_response.body)
      json.size.should == 966
    end    
  end

  describe "get /people/email" do
    before(:each) do
      Stats.registrations.truncate
    end
    
    describe "with an existing email" do
      it "should return a valid person" do
        get '/people/anders.janmyr@jayway.com'
        last_response.should be_ok
        json = JSON.parse(last_response.body)
        json['email'].should == 'anders.janmyr@jayway.com'
      end

      it "should add an entry to registrations" do
        expect {
          get '/people/anders.janmyr@jayway.com'
        }.to change {Stats.registrations.count}.by(1)
      end

      it "should add correct entry to registrations" do
        header "User-Agent", "Firefox"
        get '/people/anders.janmyr@jayway.com'
        first = Stats.registrations.first
        first[:user_agent].should == 'Firefox'
        first[:email].should == 'anders.janmyr@jayway.com'
      end
    end    
    
    describe "without exisiting email" do
      it "should return not found" do
        get '/people/missing.in@action.com'
        last_response.status.should == 404
      end
    end
  end

  describe "get /people/id" do
    before(:each) do
      Stats.connections.truncate
    end

    describe "with an existing id" do
      it "should return a valid person" do
        get '/people/92133'
        last_response.should be_ok
        json = JSON.parse(last_response.body)
        json['email'].should == 'michael.tiberg@oredev.org'
      end

      it "should add an entry to connections" do
        expect {
          get '/people/92133'
        }.to change {Stats.connections.count}.by(1)
      end

      it "should add correct entry to connections" do
        header "User-Agent", "iPad"
        get '/people/92133'
        first = Stats.connections.first
        first[:code].should == '92133'
        first[:user_agent].should == 'iPad'
      end
    end    
    
    describe "without exisiting email" do
      it "should return not found" do
        get '/people/missing.in@action.com'
        last_response.status.should == 404
      end
    end
  end
  
  describe "put /completed/digest" do
    
    describe "with valid digest" do
      it "should be ok" do
        put '/completed/43b7b0a8b4833db34b8b070e8dae413b'
        last_response.status.should == 202        
      end
      
      it "should add an entry to completions" do
        Stats.completions.truncate
        expect {
          put '/completed/43b7b0a8b4833db34b8b070e8dae413b'
        }.to change {Stats.completions.count}.by(1)
      end
    end
  end
  
  describe "post /completed/digest" do    
    describe "with valid digest" do
      it "should be ok" do
        post '/completed/43b7b0a8b4833db34b8b070e8dae413b'
        last_response.status.should == 202        
      end
      
      it "should add an entry to completions" do
        Stats.completions.truncate
        expect {
          post '/completed/43b7b0a8b4833db34b8b070e8dae413b'
        }.to change {Stats.completions.count}.by(1)
      end
    end
  end
  
  describe "get /stats" do
    before (:all) do
      Stats.registrations.truncate
      Stats.connections.truncate
      Stats.completions.truncate
      get '/people/anders.janmyr@jayway.com'
      get '/people/michael.tiberg@oredev.org'
      get '/people/03411'
      get '/people/92133'
      get '/people/36456'
      get '/people/15670'
      put '/completed/43b7b0a8b4833db34b8b070e8dae413b'
    end
    
    it "should return a statistics object" do
      pending "Cannot get this test to run" do 
        get '/stats'
        last_response.status.should == 200
        json = JSON.parse(last_response.body)
        json['registrations'].size.should == 2
        json['connections'].size.should == 4
        json['completions'].size.should == 1
      end
    end
  end
end

