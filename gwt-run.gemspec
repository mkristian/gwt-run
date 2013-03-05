# -*- coding: utf-8 -*-
require File.expand_path('lib/maven/gwt/version.rb')
Gem::Specification.new do |s|
  s.name = 'gwt-run'
  s.version = Maven::Gwt::VERSION.dup

  s.summary = 'run gwt-shell with rack/rails'
  s.description = 'start gwt-shell with rack or rails backend'

  s.homepage = 'http://github.com/mkristian/gwt-run'

  s.authors = ['Christian Meier']
  s.email = ['m.kristian@web.de']

  s.license = 'MIT'

  s.bindir = "bin"
  s.executables = ['gwt']

  s.files += Dir['bin/*']
  s.files += Dir['lib/**/*']
  s.files += Dir['spec/**/*']
  s.files += Dir['MIT-LICENSE'] + Dir['*.md']
  s.test_files += Dir['spec/**/*_spec.rb']
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'minitest', '~> 4.6'
  s.add_development_dependency 'cucumber', '~> 1.2'
  s.add_development_dependency 'copyright-header', '~> 1.0'
  s.add_runtime_dependency 'jetty-run', '~> 0.2'
end
