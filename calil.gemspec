# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'calil/version'

Gem::Specification.new do |spec|
  spec.name          = "calil"
  spec.version       = Calil::VERSION
  spec.authors       = ["2celeb"]
  spec.email         = ["oooooorz@gmail.com"]
  spec.description   = %q{calil api library ruby binding}
  spec.summary       = %q{wrapping calil api libray}
  spec.homepage      = "http://github.com/2celeb/calil"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
