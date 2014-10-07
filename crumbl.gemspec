# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "crumbl/version"

Gem::Specification.new do |s|
  s.name        = 'crumbl'
  s.version     = Crumbl::VERSION
  s.executables << 'crumbl'
  s.date        = '2014-10-07'
  s.summary     = "Read and manipulate encoded or encrypted Rails cookies"
  s.description = "Command line tool for reading and manipulating encoded or encrypted Rails cookies"
  s.authors     = ["David Lanner"]
  s.email       = 'dhlanner2@gmail.com'
  s.files       = ["lib/crumbl.rb", "lib/crumbl/base.rb", "lib/crumbl/version.rb", "bin/crumbl"]
  s.require_paths = ["lib", "bin"]
  s.homepage    =
    'http://rubygems.org/gems/crumbl'
  s.license       = 'MIT'
  s.add_runtime_dependency "rack"
  s.add_runtime_dependency "activesupport", '~> 4.0.0'
end