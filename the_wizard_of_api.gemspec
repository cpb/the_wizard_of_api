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

  spec.add_dependency "rack"
  spec.add_dependency "thin"
  spec.add_development_dependency "bcat"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "capybara-webkit"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rdiscount"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "travis-lint"
end
