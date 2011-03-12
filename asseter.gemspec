# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "asseter/version"
require 'base64'

Gem::Specification.new do |s|
  s.name        = "asseter"
  s.version     = Asseter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ "Sebastian Gamboa" ]
  s.email       = [ Base64.decode64("c2ViYUB3ZWxjdS5jb20=\n") ]
  s.homepage    = "https://github.com/sagmor/asseter"
  s.summary     = %q{Simple assets packager.}
  s.description = %q{Simple assets packager.}

  s.rubyforge_project = "asseter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
