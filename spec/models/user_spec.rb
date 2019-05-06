require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'is_keybase_provable' do
    let(:alice) { User.create!(username: 'alice', password: '1234567') }

    context 'with some proofs' do
      before do
        allow_any_instance_of(ProveKeybase::KeybaseProof).to receive :validate_with_keybase
        alice.keybase_proofs.create!(kb_username: 'c1', proof_valid: true, proof_live: true, token: '1' * 66, username: alice.username)
        alice.keybase_proofs.create!(kb_username: 'c2', proof_valid: true, proof_live: true, token: '2' * 66, username: alice.username)
        alice.keybase_proofs.create!(kb_username: 'c3', proof_valid: true, proof_live: false, token: '3' * 66, username: alice.username)
        alice.keybase_proofs.create!(kb_username: 'c4', proof_valid: false, proof_live: false, token: '4' * 66, username: alice.username)
      end

      it '.keybase_proofs.active contains the two valid and live proofs' do
        active_proofs = alice.keybase_proofs.active

        expect(active_proofs.map(&:kb_username)).to match_array(['c1', 'c2'])
      end
    end
  end
end
