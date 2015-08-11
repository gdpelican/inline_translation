# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inline_translation/version'

Gem::Specification.new do |spec|
  spec.name          = "inline_translation"
  spec.version       = InlineTranslation::VERSION
  spec.authors       = ["James Kiesel (gdpelican)"]
  spec.email         = ["james@loomio.org"]

  spec.summary       = "Store on-the-fly translations using Bing (or others!)"
  spec.description   = "Sets up a framework for allowing inline translation of database content"
  spec.homepage      = "http://www.github.com/gdpelican/inline_translation"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["app", "lib"]

  spec.add_runtime_dependency "rails", "~> 4.1"
  spec.add_runtime_dependency "bing_translator", "~> 4.4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.7"
end
