# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "itunes/version"

Gem::Specification.new do |s|
  s.name = %q{itunes}
  s.version = ITunes::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Garrett Bjerkhoel"]
  s.date = %q{2010-10-05}
  s.description = %q{iTunes API}
  s.email = %q{me@garrettbjerkhoel.com}
  s.extra_rdoc_files = [
    "MIT-LICENSE",
     "README.md"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.md",
     "lib/itunes.rb",
     "lib/itunes/version.rb"
  ]
  s.homepage = %q{http://github.com/dewski/itunes}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{itunes}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{iTunes}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end

