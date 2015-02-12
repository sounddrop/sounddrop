# -*- encoding: utf-8 -*-
# stub: kgio 2.9.3 ruby lib
# stub: ext/kgio/extconf.rb

Gem::Specification.new do |s|
  s.name = "kgio"
  s.version = "2.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["kgio hackers"]
  s.date = "2015-01-12"
  s.description = "kgio provides non-blocking I/O methods for Ruby without raising\nexceptions on EAGAIN and EINPROGRESS.  It is intended for use with the\nUnicorn and Rainbows! Rack servers, but may be used by other\napplications (that run on Unix-like platforms)."
  s.email = "kgio-public@bogomips.org"
  s.extensions = ["ext/kgio/extconf.rb"]
  s.extra_rdoc_files = ["LICENSE", "README", "TODO", "NEWS", "LATEST", "ISSUES", "HACKING", "lib/kgio.rb", "ext/kgio/accept.c", "ext/kgio/autopush.c", "ext/kgio/connect.c", "ext/kgio/kgio_ext.c", "ext/kgio/poll.c", "ext/kgio/wait.c", "ext/kgio/tryopen.c"]
  s.files = ["HACKING", "ISSUES", "LATEST", "LICENSE", "NEWS", "README", "TODO", "ext/kgio/accept.c", "ext/kgio/autopush.c", "ext/kgio/connect.c", "ext/kgio/extconf.rb", "ext/kgio/kgio_ext.c", "ext/kgio/poll.c", "ext/kgio/tryopen.c", "ext/kgio/wait.c", "lib/kgio.rb"]
  s.homepage = "http://bogomips.org/kgio/"
  s.licenses = ["LGPL-2.1+"]
  s.rubygems_version = "2.2.2"
  s.summary = "kinder, gentler I/O for Ruby"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<olddoc>, ["~> 1.0"])
      s.add_development_dependency(%q<test-unit>, ["~> 3.0"])
    else
      s.add_dependency(%q<olddoc>, ["~> 1.0"])
      s.add_dependency(%q<test-unit>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<olddoc>, ["~> 1.0"])
    s.add_dependency(%q<test-unit>, ["~> 3.0"])
  end
end
