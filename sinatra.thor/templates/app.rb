require 'sinatra'
require 'sinatra/reloader'

require 'bundler'
Bundler.require


get '/env' do
  p request.env
  request.env.inspect
end
