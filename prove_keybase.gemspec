$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'prove_keybase/version'

Gem::Specification.new do |spec|
  spec.name        = 'prove_keybase'
  spec.version     = ProveKeybase::VERSION
  spec.authors     = ['Alex Gessner']
  spec.email       = ['alex@keyba.se']
  spec.homepage    = 'https://keybase.io'
  spec.summary     = 'Add the Keybase open protocol for identity proofs to your Rails app'
  spec.description = 'Add the Keybase open protocol for identity proofs to your Rails app'
  spec.license     = 'BSD-3'
  spec.files = Dir[
    '{app,config,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  spec.add_dependency 'active_model_serializers'
  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'rails', "~> #{ENV['RAILS_VERSION'] || '5.2.3'}"

  spec.add_development_dependency 'bcrypt'
  # spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec-rails'
  # spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'travis'
  spec.add_development_dependency 'webmock'
end
