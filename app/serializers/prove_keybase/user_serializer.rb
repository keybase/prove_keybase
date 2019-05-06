class ProveKeybase::UserSerializer < ActiveModel::Serializer
  attributes :avatar_url
  has_many :keybase_proofs, key: :signatures

  class KeybaseProofSerializer < ActiveModel::Serializer
    attributes :sig_hash, :kb_username

    def sig_hash
      object.token
    end
  end
end
