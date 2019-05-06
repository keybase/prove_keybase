# frozen_string_literal: true

ProveKeybase.setup do |config|
  # REQUIRED
  config.domain = 'dummy.example'
  running_host = ENV.fetch('KEYBASE_PROXY_HOST') { config.domain }
  config.profile_url = "https://#{running_host}/users/%{username}"
  config.display_name = 'Dummy'
  config.description = 'im the dummy app'
  config.brand_color = '#282c37'
  config.user_min_length = 2
  config.user_max_length = 30
  config.user_re = '[a-z0-9_]+([a-z0-9_.-]+[a-z0-9_]+)?'
  config.logo_svg_full = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_full.svg'
  config.logo_svg_black = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_black.svg'
  config.contact = ['dummy@example.com']

  # OPTIONAL
  # config.job_queue = :default

  # this is the route_helper method to which a user will be redirected who is
  # trying to create a proof without being logged in, or if they're logged in
  # as the wrong user. See the readme for details on overriding this behavior
  # if you'd like more control over the experience.
  # config.login_redirection = :root_url

  # recommend putting this image (or similar) in your asset pipeline and updating here
  # config.default_keybase_avatar_url = 'https://keybase.io/images/icons/icon-keybase-logo-64@2x.png'

  # You probably don't need to touch these unless you're actively developing on this
  # gem as opposed to merely configuring it for an existing application.
  # config.keybase_base_url = ENV.fetch("KEYBASE_BASE_URL") { 'https://keybase.io' }
  # config.domain_for_urls = running_host
end
