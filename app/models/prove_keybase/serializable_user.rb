class ProveKeybase::SerializableUser
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Serialization

  attr_accessor :keybase_proofs, :avatar_url

  def persisted?
    false
  end

  def initialize(keybase_proofs, avatar_url)
    @keybase_proofs = keybase_proofs
    @avatar_url = avatar_url
  end
end
