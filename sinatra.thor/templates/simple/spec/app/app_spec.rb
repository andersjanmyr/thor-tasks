# encoding: UTF-8
require 'spec_helper'
require 'json'
require 'app'

describe 'Application' do

  def app
    Sinatra::Application
  end

  it "get /env shows the environment" do
    get '/env'
    last_response.should be_ok
    last_response.body.should match(/PATH_INFO/)
  end

end

