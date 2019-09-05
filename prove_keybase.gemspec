$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'prove_keybase/version'

Gem::Specification.new do |spec|
  spec.name        = 'prove_keybase'
  spec.version     = ProveKeybase::VERSION
  spec.authors     = ['Alex Gessner']
  spec.email       = ['alex@keyba.se']
  spec.homepage    = 'https://keybase.io'
  spec.summary     = 'Add the Keybase open protocol for identity proofs to your Rails app'
  spec.description = 'Add the Keybase open protocol for identity proofs to your Rails app. There\'s a bunch of docs for how to use it.'
  spec.license     = 'BSD-3-Clause'
  spec.files = Dir[
    '{app,config,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  spec.required_ruby_version = '>= 2.3.0'

  spec.add_dependency 'active_model_serializers', '~>0.10'
  spec.add_dependency 'faraday', '~>0.15'
  spec.add_dependency 'faraday_middleware', '~>0.13'

  spec.add_development_dependency 'bcrypt', '~>3.1'
  spec.add_development_dependency 'rspec-rails', '~>3.8'
  spec.add_development_dependency 'sqlite3', '~>1.4'
  spec.add_development_dependency 'travis', '~>1.8'
  spec.add_development_dependency 'webmock', '~>3.7'
end
