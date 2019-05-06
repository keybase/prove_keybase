# frozen_string_literal: true

class ProveKeybase::KeybaseProof < ProveKeybase::BaseRecord
  self.table_name = 'keybase_proofs'

  validates :token, format: { with: /\A[a-f0-9]+\z/ }, length: { is: 66 }
  validate :validate_with_keybase, if: :token_changed?

  scope :active, -> { where(proof_valid: true, proof_live: true) }

  delegate :on_success_path, :keybase_avatar_url, :profile_url,
           :proof_url, :badge_url, :refresh, :refresh!,
           to: :remote_adapter

  def remote_adapter
    @remote_adapter ||= ::ProveKeybase::KeybaseAdapter.new(self)
  end

  def validate_with_keybase
    remote_adapter.validate!
  end
end
