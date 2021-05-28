# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'legacy_serializer/serializer/version'

Gem::Specification.new do |spec|
  spec.name          = "legacy_serializer"
  spec.version       = LegacySerializer::Serializer::VERSION
  spec.authors       = ["Steve Klabnik"]
  spec.email         = ["steve@steveklabnik.com"]
  spec.summary       = %q{Conventions-based JSON generation for Rails.}
  spec.homepage      = "https://github.com/runtastic/legacy_serializer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 4.0"

  spec.add_development_dependency "rails", ">= 4.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
