# frozen_string_literal: true

require_relative 'boot'

require 'active_job/railtie'
require 'active_record/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)
require 'prove_keybase'

module Dummy
  class Application < Rails::Application
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join('app', 'assets', 'images')
    config.active_job.queue_adapter = :async
  end
end
