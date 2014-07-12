# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_csv_renderer/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_csv_renderer"
  spec.version       = RailsCsvRenderer::VERSION
  spec.authors       = ["Dennis Sheleh"]
  spec.email         = ["den.sheleh@gmail.com"]
  spec.summary       = %q{Add custom csv renderer for Rails application}
  spec.description   = %q{Add custom csv renderer for Rails application}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 3.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
end
