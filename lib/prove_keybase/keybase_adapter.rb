class ProveKeybase::ExpectedProofLiveError < StandardError; end

class ProveKeybase::KeybaseAdapter
  def initialize(proof)
    @proof = proof
    @domain = ProveKeybase.configuration.domain
    @base_url = ProveKeybase.configuration.keybase_base_url
  end

  def validate!
    if keybase_valid?
      @proof.proof_valid = true
    else
      @proof.errors.add(:base, 'token not valid for user combo in keybase')
    end
  end

  def refresh
    ProveKeybase::UpdateFromKeybaseJob.perform_later(@proof.id)
  end

  def refresh!
    status = client.remote_status

    # if Keybase thinks the proof is valid but not live, yet the proof exists locally,
    # then this is very likely during the creation flow, and Keybase just hasn't
    # fetched the proof through the API yet. Throw this specific error so we know to
    # retry.
    raise ProveKeybase::ExpectedProofLiveError if status[:proof_valid] && !status[:proof_live]

    @proof.update!(status.slice(:proof_valid, :proof_live))
  end

  def keybase_valid?
    client.proof_valid?
  end

  def keybase_live?
    client.proof_live?
  end

  def on_success_path(kb_ua)
    uri = URI.parse(File.join(@base_url, '/_/proof_creation_success'))
    uri.query = URI.encode_www_form(proof_params.merge(kb_ua: kb_ua || 'unknown'))
    uri.to_s
  end

  def keybase_avatar_url
    client.pic_url
  end

  def proof_url
    File.join(@base_url, "#{@proof.kb_username}/sigchain\##{@proof.token}")
  end

  def profile_url
    File.join(@base_url, @proof.kb_username)
  end

  def badge_url
    File.join(@base_url, "#{@proof.kb_username}/proof_badge/#{@proof.token}?username=#{@proof.username}&domain=#{@domain}")
  end

  private

  def proof_params
    {
      domain: @domain,
      username: @proof.username,
      kb_username: @proof.kb_username,
      sig_hash: @proof.token
    }
  end

  def client
    @client ||= ProveKeybase::KeybaseClient.new(proof_params, @base_url)
  end
end
