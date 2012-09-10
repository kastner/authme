require 'authme'
require 'test/unit'
require 'rack/test'
require 'shoulda'

ENV['RACK_ENV'] = 'test'

class MockApp < Sinatra::Base
  get '/' do; 'hi'; end
end

def rack_app(extra = "use Authme::Middleware")
  Rack::Builder.new do
    use Rack::Lint
    eval(extra)
    run MockApp
  end
end

class TestBasics < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    rack_app
  end

  should "should say hi" do
    get '/'
    assert_equal 'hi', last_response.body
  end

  should "add headers" do
    get '/'
    raise last_response.headers.inspect
    assert last_response.headers.has_key?("AUTHME_AUTHED")
  end

  #should "auth if the right headers exist" do
  #end
end

class TestAuth < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    rack_app(%q{use Authme::Middleware, {:a => {:pass => "foo"}}})
  end

  should "get through" do
    get '/authfoo'
    assert_equal 'hi there', last_response.body
  end

  #should "validate" do
  #  post '/auth', {:username => "a", :password => "foo"}
  #  assert_equal "a", last_response.headers["AUTHME_USER"]
  #end
end

