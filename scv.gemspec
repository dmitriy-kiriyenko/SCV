# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scv/version"

Gem::Specification.new do |s|
  s.name        = "scv"
  s.version     = SCV::VERSION
  s.authors     = ["Dmitriy Kiriyenko"]
  s.email       = ["dmitriy.kiriyenko@anahoret.com"]
  s.homepage    = ""
  s.summary     = %q{A set of thor scripts to manage rails application basic tasks}
  s.description = %q{A set of thor scripts to manage rails application basic tasks.
                     Such as managing local configuration files, dropping, creating
                     and populating db, etc.}

  s.rubyforge_project = "scv"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"

  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "database_cleaner"
  s.add_runtime_dependency "railties"
end
