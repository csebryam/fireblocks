# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fireblocks/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.3.0'

  spec.name          = 'fireblocks'
  spec.version       = Fireblocks::VERSION
  spec.authors       = ['Bryam Noguera', 'Matt Culpepper']
  spec.email         = ['bryamnoguera@yahoo.com', 'matt@culpepper.co']

  spec.summary       = 'Ruby wrapper for Fireblocks API'
  spec.homepage      = 'https://github.com/fundamerica/fireblocks'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']
  spec.files = Dir['lib/**/*.rb', 'LICENSE.txt', 'README.md']
  spec.test_files = Dir['test/**/*.rb']

  spec.add_runtime_dependency 'jwt', '~> 2.2'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop',  '~> 0.56'
  spec.add_development_dependency 'figaro'
end
