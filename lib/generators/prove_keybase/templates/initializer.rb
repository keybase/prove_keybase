# frozen_string_literal: true

# See https://keybase.io/docs/proof_integration_guide for more details on
# how this integration works.
ProveKeybase.setup do |config|
  # These two values are how users will lookup your site on Keybase
  config.domain = 'yoursite.com'
  config.display_name = 'Bee Activists'

  # In the unlikely event that your site is actually running on a different
  # domain (perhaps a subdomain, or for testing/staging purposes) you might
  # want to specify that the URLs are actually on a different domain. This
  # will default to `config.domain` above, so you can safely ignore this.
  # config.domain_for_urls = 'yoursite.com'

  # This is the URL to which a Keybase user will be linked when they click
  # on a proof of one of your users. Please leave `%{username}` for interpolation
  # by Keybase. This page should link back to Keybase when a user has active
  # proofs.
  config.profile_url = "https://yoursite.com/users/%{username}"

  config.description = 'Next gen social network using big data & AI in the cloud 🤖☁️.'
  config.brand_color = '#282c37'

  # Keybase will use these as an early pre-check before creating the proof and signature
  config.user_min_length = 2
  config.user_max_length = 30
  config.user_re = '^[a-zA-Z0-9_]{2,30}$'

  # A full color SVG. Should look good at 32px square. Expand all texts and strokes to shapes.
  # Here's an example of a good one.
  config.logo_svg_full = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_full.svg'

  # A full-black monochrome SVG. Should look good at 16px square. Expand all texts and strokes to shapes.
  # Here's an example of a good one.
  config.logo_svg_black = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_black.svg'

  # So Keybase has someone to reach out to if there are any issues
  config.contact = ['dummy@yoursite.com', 'beezkneez@keybase']

  # After creating a proof locally, there is an async task to check that Keybase has seen it and updated
  # accordingly. The queue on which this is running can be configured here.
  # config.job_queue = :default

  # This is the route_helper method to which a user will be redirected who is
  # trying to create a proof without being logged in, or if they're logged in
  # as the wrong user. See the readme for details on overriding this behavior
  # if you'd like more control over the experience. Ideally, if a user is
  # redirected, they will be sent back to the correct page after logging in.
  config.login_redirection = :new_signin_path

  # recommend putting this image (or similar) in your asset pipeline and updating this
  config.default_keybase_avatar_url = 'https://keybase.io/images/icons/icon-keybase-logo-64@2x.png'
end
