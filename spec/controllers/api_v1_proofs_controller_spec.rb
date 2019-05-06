# frozen_string_literal: true

require 'rails_helper'

describe ProveKeybase::ApiV1ProofsController, type: :controller do
  routes { ProveKeybase::Engine.routes }
  render_views

  describe '#show' do
    let(:alice) { User.create!(username: 'alice', password: '1234567') }
    let(:bob) { User.create!(username: 'bob', password: '1234567') }

    context 'with an unknown user' do
      it '404s' do
        get :show, params: { username: 'idontexist' }

        expect(response.status).to eq(404)
      end
    end

    context 'with a user that has no proofs' do
      let(:expected_empty_response) do
        { 'avatar_url' => 'face.png', 'signatures' => [] }
      end

      it 'is an empty response' do
        get :show, params: { username: alice.username }

        expect(JSON.parse(response.body)).to eq expected_empty_response
        expect(response.status).to eq 200
      end
    end

    context 'with alice who has two proofs' do
      before do
        allow_any_instance_of(ProveKeybase::KeybaseProof).to receive :validate_with_keybase
        alice.keybase_proofs.create!(username: alice.username, token: '1' * 66, kb_username: 'cryptoalice1')
        alice.keybase_proofs.create!(username: alice.username, token: '2' * 66, kb_username: 'cryptoalice2')
      end

      context 'and another user with one proof' do
        before do
          bob.keybase_proofs.create!(username: bob.username, token: '3' * 66, kb_username: 'defbob')
        end

        let(:expected_response) do
          { 'avatar_url' => 'face.png', 'signatures' => [
            { 'sig_hash' => '111111111111111111111111111111111111111111111111111111111111111111', 'kb_username' => 'cryptoalice1' },
            { 'sig_hash' => '222222222222222222222222222222222222222222222222222222222222222222', 'kb_username' => 'cryptoalice2' }
          ] }
        end

        it 'is alice\'s two proofs' do
          get :show, params: { username: alice.username }

          actual_response = JSON.parse(response.body)
          expect(actual_response).to eq expected_response
        end
      end
    end
  end
end