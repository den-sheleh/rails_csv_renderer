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
  spec.homepage      = "http://github.com/den-sheleh/rails_csv_renderer"
  spec.license       = "MIT"
  spec.platform      = Gem::Platform::RUBY
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_runtime_dependency 'activerecord', '>= 4.0'
  spec.add_runtime_dependency 'actionpack', '>= 4.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1.1'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'sqlite3'
end
