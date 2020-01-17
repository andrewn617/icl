# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','icl','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'icl'
  s.version = Icl::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A command line app for working with XSLT transforms.'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.extra_rdoc_files = ['README.rdoc','icl.rdoc']
  s.rdoc_options << '--title' << 'icl' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'icl'
  s.add_development_dependency('rake')
  s.add_runtime_dependency('gli','2.19.0')
  s.add_runtime_dependency('nokogiri')
end
