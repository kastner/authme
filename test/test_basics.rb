require 'authme'
require 'test/unit'
require 'rack/test'
require 'shoulda'
require 'json'

class TestAuthme < Test::Unit::TestCase
  def app(extra)
    Rack::Builder.new do
      eval extra
      use Rack::Lint
      run lambda {|env| [200, {'Content-Type' => 'text/plain'}, [env.to_json]]}
    end
  end

  def request(extra = nil)
    Rack::MockRequest.new(app(extra || "use Authme::Middleware"))
  end

  context "basics" do
    should "see the header in later apps" do
      response = request.get '/'
      assert_equal 'false', JSON.parse(response.body)["AUTHME_AUTHED"]
    end

    should "not see the header after the request" do
      response = request.get '/'
      assert !response.headers.include?("AUTHME_AUTHED")
    end
  end

  context "authentication" do
    setup do
      extra = "use Authme::Middleware, {:foo => {:pass => 'bar'}}"
      @req = request(extra)
      @response = @req.post '/auth', :input => "user=foo&pass=bar"
    end

    should "get urls" do
      response = request.get '/authfoo'
      assert_equal 'hi there', response.body
    end

    should "auth users" do
      assert_equal 302, @response.status
      assert @response["Set-Cookie"].match(/rack.session=/)
    end

    should "set headers for authed users" do
      response = @req.get("/", {"HTTP_COOKIE" => @response["Set-Cookie"]})
      assert_equal "foo", JSON.parse(response.body)["AUTHME_USER"]
    end
  end
end

