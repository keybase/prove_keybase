class ProveKeybase::SerializableUser
  include ActiveModel::Serialization
  attr_accessor :keybase_proofs, :avatar_url

  def initialize(keybase_proofs, avatar_url)
    @keybase_proofs = keybase_proofs
    @avatar_url = avatar_url
  end
end
