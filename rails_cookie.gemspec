# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_cookie/version"

Gem::Specification.new do |s|
  s.name        = 'rails_cookie'
  s.version     = RailsCookie::VERSION
  s.executables << 'rails_cookie'
  s.date        = '2014-10-06'
  s.summary     = "Manipulate encoded or encrypted Rails cookies"
  s.description = "Manipulate encoded or encrypted Rails cookies"
  s.authors     = ["David Lanner"]
  s.email       = 'dhlanner2@gmail.com'
  s.files       = ["lib/rails_cookie.rb", "lib/rails_cookie/base.rb", "lib/rails_cookie/version.rb", "bin/rails_cookie"]
  s.require_paths = ["lib", "bin"]
  s.homepage    =
    'http://rubygems.org/gems/rails_cookie'
  s.license       = 'MIT'
  s.add_runtime_dependency "rack"
  s.add_runtime_dependency "activesupport", '~> 4.0.0'
end