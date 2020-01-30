module ProveKeybase
  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Serialization

    def persisted?
      false
    end

    attr_accessor :domain, :display_name, :description, :brand_color,
                  :user_min_length, :user_max_length, :user_re, :logo_svg_full,
                  :logo_svg_white, :logo_svg_full_darkmode,
                  :logo_svg_black, :profile_url, :contact, :keybase_base_url,
                  :default_keybase_avatar_url, :job_queue, :login_redirection,
                  :_domain_for_urls

    def initialize
      # defaults
      @job_queue = :default
      @login_redirection = :root_path
      @default_keybase_avatar_url = 'https://keybase.io/images/icons/icon-keybase-logo-64@2x.png'
      @keybase_base_url = ENV.fetch('KEYBASE_BASE_URL') { 'https://keybase.io' }
    end

    def domain_for_urls
      @_domain_for_urls || @domain
    end
  end
end
