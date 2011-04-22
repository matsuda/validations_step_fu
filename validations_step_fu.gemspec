# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "validations_step_fu/version"

Gem::Specification.new do |s|
  s.name        = "validations_step_fu"
  s.version     = ValidationsStepFu::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kosuke Matsuda"]
  s.email       = ["hi@matsuda.me"]
  s.homepage    = "https://github.com/matsuda/validations_step_fu"
  s.summary     = %q{A extension activemodel's validations to validation step by step.}
  s.description = %q{A extension activemodel's validations to validation step by step.}

  s.rubyforge_project = "validations_step_fu"
  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "railties", ">= 3.0.0"
  s.add_dependency "activemodel", ">= 3.0.0"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rails", ">= 3.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
