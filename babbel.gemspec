# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'babbel/version'

Gem::Specification.new do |spec|
  spec.name          = "babbel"
  spec.version       = Babbel::VERSION
  spec.authors       = ["James Kiesel"]
  spec.email         = ["james.kiesel@gmail.com"]
  spec.summary       = %q{Store on-the-fly translations using Bing (or others!)}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://www.github.com/gdpelican/babbel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">~ 3.1.0"
end
