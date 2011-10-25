# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "itunes/version"

Gem::Specification.new do |s|
  s.name = "itunes"
  s.version = ITunes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Garrett Bjerkhoel", "Steve Agalloco"]
  s.email = %q{me@garrettbjerkhoel.com}
  s.homepage = %q{http://github.com/dewski/itunes}
  s.summary = %q{iTunes API}

  s.rubyforge_project = "itunes"

  s.extra_rdoc_files = [
    "MIT-LICENSE",
     "README.md"
  ]
  s.rdoc_options = ["--charset=UTF-8"]

  s.add_development_dependency('rake', '~> 0.9')
  s.add_development_dependency('rspec', '~> 2.7')
  s.add_development_dependency('yard', '~> 0.7')
  s.add_development_dependency('maruku', '~> 0.6')
  s.add_development_dependency('simplecov', '~> 0.4.2')
  s.add_development_dependency('webmock', '~> 1.7')
  s.add_development_dependency('vcr', '~> 1.11')

  s.add_runtime_dependency('hashie', '~> 1.1')
  s.add_runtime_dependency('rash', '~> 0.3')
  s.add_runtime_dependency('faraday_middleware', '~> 0.7')
  s.add_runtime_dependency('multi_json', '~> 1.0.3')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

