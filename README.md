# Authme

Rack middleware for authentication

## Installation

Add this line to your application's Gemfile:

    gem 'authme'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install authme

## Usage

Any downstream rack handlers will have some extra headers injected:

  * `AUTHME_USER`: username
  * `AUTHME_AUTHED`: timestamp of auth time or false for un-authed


## Providers

Auth Me supports different authentication providers:

  * Rack::Auth::Basic
  * User / Pass in `authme.yml`
  * Twitter (TODO)
  * Google (TODO)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
