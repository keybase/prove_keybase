class ProveKeybase::KeybaseClient
  def initialize(proof_params, base_url)
    @proof_params = proof_params
    api_url = File.join(base_url, '/_/api/1.0/')
    @api_conn = Faraday::Connection.new(url: api_url) do |faraday|
      faraday.response :json
      faraday.adapter :net_http
    end
  end

  def pic_url
    res = @api_conn.get('user/pic_url.json', username: @proof_params[:kb_username]).body
    res.fetch('pic_url')
  rescue NoMethodError, KeyError, Faraday::Error
    ProveKeybase.configuration.default_keybase_avatar_url
  end

  def proof_valid?
    res = @api_conn.get('sig/proof_valid.json', @proof_params).body
    res.fetch('proof_valid', false)
  rescue Faraday::Error
    false
  end

  def proof_live?
    res = @api_conn.get('sig/proof_live.json', @proof_params).body
    res.fetch('proof_live', false)
  rescue Faraday::Error
    false
  end

  def remote_status
    # allow network and unexpected response errors to bubble up
    res = @api_conn.get('sig/proof_live.json', @proof_params).body
    { proof_valid: res.fetch('proof_valid'),
      proof_live: res.fetch('proof_live') }
  end
end
