# frozen_string_literal: true

ProveKeybase.setup do |config|
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
  config.logo_svg_full_darkmode = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_svg_full_darkmode.svg'
  config.logo_svg_black = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_black.svg'
  config.logo_svg_white = 'https://keybase.io/images/paramproofs/services/gubble.cloud/logo_white.svg'
  config.contact = ['dummy@example.com']
end
