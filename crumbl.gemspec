# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "crumbl/version"

Gem::Specification.new do |s|
  s.name        = 'crumbl'
  s.version     = Crumbl::VERSION
  s.date        = '2014-10-08'
  s.summary     = "Read and write encoded or encrypted Rails cookies"
  s.description = "Command line tool for reading and writing encoded or encrypted Rails cookies"
  s.authors     = ["David Lanner"]
  s.email       = 'dhlanner2@gmail.com'
  s.files       = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib", "bin"]
  s.homepage    =
    'https://github.com/dlanner/crumbl'
  s.license       = 'MIT'
  s.add_development_dependency "minitest",  "~> 5"
  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "activesupport", '~> 4.2.0'
end