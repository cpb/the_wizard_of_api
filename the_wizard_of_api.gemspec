# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_wizard_of_api/version'

Gem::Specification.new do |spec|
  spec.name          = "the_wizard_of_api"
  spec.version       = TheWizardOfApi::VERSION
  spec.authors       = ["Caleb Buxton"]
  spec.email         = ["me@cpb.ca"]
  spec.description   = %q{A API Service for Wizard of Oz style testing.}
  spec.summary       = %q{Enables a human-wizard to craft each response for a yet unimplemented API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faye", "~> 0.8"
  spec.add_dependency "rack", "~> 1.5"
  spec.add_dependency "thin", "~> 1.5"
  spec.add_development_dependency "bcat", "~> 0.6"
  spec.add_development_dependency "capybara", "~> 2.1"
  spec.add_development_dependency "capybara-webkit", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry", "~> 0.9.12"
  spec.add_development_dependency "rack-test", "~> 0.5"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rdiscount", "~> 2.0.7"
  spec.add_development_dependency "rest-client", "~> 1.6"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "travis-lint", "~> 1.7"
end
