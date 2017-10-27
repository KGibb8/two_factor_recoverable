# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "two_factor_recovery/version"

Gem::Specification.new do |s|
  s.name        = "two_factor_recovery"
  s.version     = TwoFactorRecovery::VERSION.dup
  s.authors     = ["Dmitrii Golub"]
  s.email       = ["dmitrii.golub@gmail.com"]
  s.homepage    = "https://github.com/kyphae/two_factor_recovery"
  s.summary     = %q{Two factor recovery plugin for devise}
  s.description = <<-EOF
    ### Features ###
    * authenticate with recovery code
    * recovery code generators
  EOF

  s.rubyforge_project = "two_factor_recovery"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rails', '>= 3.1.1'
  s.add_runtime_dependency 'devise'
  s.add_runtime_dependency 'randexp'
  s.add_runtime_dependency 'rotp', '>= 3.2.0'
  s.add_runtime_dependency 'encryptor'
  s.add_runtime_dependency 'two_factor_authentication'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails', '>= 3.0.1'
  s.add_development_dependency 'capybara', '2.4.1'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'timecop'
end
