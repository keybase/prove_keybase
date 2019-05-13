# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.test?
  ProveKeybase.configuration.domain = 'example.test'
  ProveKeybase.configuration.profile_url = 'https://example.test/users/%{username}'

  class ActionDispatch::TestRequest
    def host
      'example.test'
    end
  end
end
