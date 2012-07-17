# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "billable/version"

Gem::Specification.new do |s|
  s.name        = "billable"
  s.version     = Billable::VERSION
  s.authors     = ["Sathish"]
  s.email       = ["sathish316@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Billable is a cmdline utility to fill time sheets using Git logs and mechanize.}
  s.description = %q{Billable is a cmdline utility to fill time sheets using Git logs and mechanize.}

  s.rubyforge_project = "billable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_runtime_dependency "mechanize"
  s.add_runtime_dependency "trollop"
  s.add_runtime_dependency "active_support"
end