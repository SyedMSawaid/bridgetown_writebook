# frozen_string_literal: true

require_relative "lib/bridgetown_writebook/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown_writebook"
  spec.version       = BridgetownWritebook::VERSION
  spec.author        = "Syed Muhammad Sawaid"
  spec.email         = "smsawaid3@gmail.com"
  spec.summary       = "WriteBook style books for your static website"
  spec.homepage      = "https://github.com/syedmsawaid/bridgetown_writebook"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^test/!)
  spec.require_paths = ["lib"]
  # Uncomment this if you wish to supply a companion NPM package:
  # spec.metadata      = { "yarn-add" => "bridgetown_writebook@#{BridgetownWritebook::VERSION}" }

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "bridgetown", ">= 1.2.0", "< 2.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.3"
end
