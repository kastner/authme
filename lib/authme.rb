require 'sinatra'
require 'authme/version'

module Authme
  class Middleware < Sinatra::Base
    enable :sessions

    def initialize(*args)
      @options = args.pop if args.length > 1
      super
    end

    before do
      if session["authme_user"]
        env["AUTHME_AUTHED"] = "true"
        env["AUTHME_USER"] = session["authme_user"]
        env["AUTHME_FROM"] = session["authme_from"]
      else
        env["AUTHME_AUTHED"] = "false"
      end
    end

    get '/authfoo' do
      "hi there"
    end

    post '/auth' do
      if @options && @options.has_key?(params["user"].to_sym) && @options[params["user"].to_sym][:pass] == params["pass"]
        env["AUTHME_USER"] = params["user"]
        session["authme_user"] = params["user"]
        session["authme_from"] = "list"
        redirect '/'
      else
        403
      end
    end

    get // do
      pass
    end
  end
end

