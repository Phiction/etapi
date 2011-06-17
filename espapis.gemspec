lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include? lib

require "espapis/version"

Gem::Specification.new do |s|
  s.name        = "espapis"
  s.version     = ESP::Version
  s.authors     = ["Chris McGrath"]
  s.email       = ["mcgrath.chris@gmail.com"]
  s.homepage    = %q{http://github.com/phiction/espapis}
  s.summary     = %q{Ruby Library for Various Email Service Provider APIs}
  s.description = %q{This is an attempt to make integrating easier with various Email Service Provider (ESP) APIs.}

  s.rubyforge_project = "espapis"
  
  s.add_dependency("builder",  ">= 2.1.2")
  s.add_dependency("nokogiri", ">= 1.4.1")
  
  s.files         = `git ls-files`.split("\n")
  s.require_path  = "lib"
end
