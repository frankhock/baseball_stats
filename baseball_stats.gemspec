# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baseball_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "baseball_stats"
  spec.version       = BaseballStats::VERSION
  spec.authors       = ["Frank Hock"]
  spec.email         = ["frank@reenhanced.com"]
  spec.summary       = "Online Baseball Stats"
  spec.description   = "Calculate Baseball Stats"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
