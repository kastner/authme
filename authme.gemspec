# -*- encoding: utf-8 -*-
require File.expand_path('../lib/authme/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Erik Kastner"]
  gem.email         = ["kastner@gmail.com"]
  gem.description   = %q{Rack middleware for authentication}
  gem.summary       = %q{Rack middleware for authentication}
  gem.homepage      = "http://github.com/kastner/authme"

  gem.add_dependency(%q<rack>, ["~> 1.4.1"])
  gem.add_dependency(%q<sinatra>, ["~> 1.3.3"])

  gem.add_development_dependency(%q<shoulda>, ["~> 3.1.1"])
  gem.add_development_dependency(%q<rack-test>, ["~> 0.6.1"])
  gem.add_development_dependency(%q<json>)

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "authme"
  gem.require_paths = ["lib"]
  gem.version       = Authme::VERSION
end
