# -*- encoding: utf-8 -*-
# stub: soundcloud 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "soundcloud"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Johannes Wagener"]
  s.date = "2013-08-19"
  s.description = "The official SoundCloud API wrapper. It provides simple methods to handle authorization and to execute HTTP calls."
  s.email = ["johannes@soundcloud.com"]
  s.homepage = "http://dev.soundcloud.com"
  s.rubygems_version = "2.2.2"
  s.summary = "The official SoundCloud API wrapper."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httmultiparty>, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<hashie>, ["~> 2.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
    else
      s.add_dependency(%q<httmultiparty>, ["~> 0.3.0"])
      s.add_dependency(%q<hashie>, ["~> 2.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<httmultiparty>, ["~> 0.3.0"])
    s.add_dependency(%q<hashie>, ["~> 2.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
  end
end
