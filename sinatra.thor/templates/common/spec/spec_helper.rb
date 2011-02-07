$LOAD_PATH.unshift File.dirname(__FILE__) + '/..'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'bundler'
Bundler.require

require 'rack/test'

set :environment, :test

Rspec.configure do |c|
  c.include Rack::Test::Methods
  c.mock_with :rspec
end
