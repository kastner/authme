require 'sinatra'
require 'authme/version'

module Authme
  class Middleware < Sinatra::Application
    def initialize(app, options={})
      @app = app
      @options = options
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      status, headers, response = @app.call(env)
      headers["AUTHME_AUTHED"] = "false"
      [status, headers, response]
    end

    get '/authfoo' do
      "hi there"
    end

    #post '/auth' do
    #  "HI!"
    #  raise params.inspect
    #end
  end
end

