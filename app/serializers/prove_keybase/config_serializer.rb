# frozen_string_literal: true

class ProveKeybase::ConfigSerializer < ActiveModel::Serializer
  attributes :version, :domain, :display_name, :username,
             :brand_color, :logo, :description, :prefill_url,
             :profile_url, :check_url, :check_path, :avatar_path,
             :contact

  def version
    1
  end

  def logo
    { svg_black: object.logo_svg_black,
      svg_white: object.logo_svg_white,
      svg_full: object.logo_svg_full,
      svg_full_darkmode: object.logo_svg_full_darkmode, }
  end

  def username
    { min: object.user_min_length,
      max: object.user_max_length,
      re: object.user_re }
  end

  def prefill_url
    params = {
      kb_username: '%{kb_username}',
      username: '%{username}',
      token: '%{sig_hash}',
      kb_ua: '%{kb_ua}'
    }
    generate_url(:new_proof_url, params)
  end

  def check_url
    params = { username: '%{username}' }
    generate_url(:check_proof_url, params)
  end

  def check_path
    ['signatures']
  end

  def avatar_path
    ['avatar']
  end

  private

  def generate_url(route, params)
    opts = params.merge(host: ProveKeybase.configuration.domain_for_urls, protocol: 'https')
    CGI.unescape(
      ProveKeybase::Engine.routes.url_helpers.send(route, opts)
    )
  end
end
