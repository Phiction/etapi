lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include? lib

require "etapi/version"

Gem::Specification.new do |s|
  s.name        = "etapi"
  s.version     = ETAPI::Version
  s.authors     = ["Chris McGrath"]
  s.email       = ["mcgrath.chris@gmail.com"]
  s.homepage    = %q{http://github.com/phiction/etapi}
  s.summary     = %q{Ruby Wrapper for Exact Target's APIs}
  s.description = %q{This is an attempt to make integrating easier with Exact Target's XML and SOAP APIs.}

  s.rubyforge_project = "etapi"
  
  s.add_dependency("builder",  ">= 2.1.2")
  s.add_dependency("nokogiri", ">= 1.4.1")
  
  s.files         = `git ls-files`.split("\n")
  s.require_path  = "lib"
end
