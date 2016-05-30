# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quintype/api/version'

Gem::Specification.new do |spec|
  spec.name          = "quintype-api"
  spec.version       = Quintype::Api::VERSION
  spec.authors       = ["Tejas Dinkar"]
  spec.email         = ["tejas@gja.in"]

  spec.summary       = %q{Ruby Gem to Access the Quintype API}
  spec.homepage      = "https://github.com/quintype/quintype-api-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9.2"
  spec.add_dependency "faraday_middleware", "~> 0.10.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
