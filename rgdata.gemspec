# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'rgdata/version'

Gem::Specification.new do |s|
  s.name        = 'rgdata'
  s.version     = Rgdata::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jared Ning']
  s.email       = ['jared@redningja.com']
  s.homepage    = 'https://github.com/ordinaryzelig/rgdata'
  s.summary     = %q{Google Data API for Ruby}
  s.description = %q{Google Data API for Ruby}

  s.rubyforge_project = 'rgdata'

  s.files         = `git ls-files`.split()
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'httparty', '~> 0.7.4'

  s.add_development_dependency 'minitest', '2.0.2'
end
