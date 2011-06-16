# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "esp-apis/version"

Gem::Specification.new do |s|
  s.name        = "esp-apis"
  s.version     = ESP::VERSION
  s.authors     = ["Chris McGrath"]
  s.email       = ["mcgrath.chris@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Library for Various Email Service Provider APIs}
  s.description = %q{This is an attempt to make integrating easier with various Email Service Provider (ESP) APIs.}

  s.rubyforge_project = "esp-apis"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
