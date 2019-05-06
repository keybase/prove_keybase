# frozen_string_literal: true

require 'rails_helper'

describe ProveKeybase::ProofsController, type: :controller do
  routes { ProveKeybase::Engine.routes }
  render_views

  describe '#new' do
    let(:token) { '1' * 66 }
    let(:username) { 'alice' }
    let(:kb_username) { 'cryptoalice' }
    let(:domain) { 'example.test' }
    let(:proof_params) do
      {
        username: username,
        kb_username: kb_username,
        token: token,
        kb_ua: 'useragent'
      }
    end
    let(:alice) { User.create!(username: 'alice', password: '1234567') }
    let(:bob) { User.create!(username: 'bob', password: '1234567') }

    before { stub_request(:any, %r{https:\/\/keybase\.io}) }

    context 'when not logged in' do
      it 'redirects to the login page' do
        get :new, params: proof_params

        expect(response).to redirect_to(Rails.application.routes.url_helpers.root_path)
      end
    end

    context 'when logged in' do
      before do
        session[:user_id] = alice.id
      end

      it 'loads the overriden `new` view with params' do
        get :new, params: proof_params

        expect(response.body).to include('overridden by the dummy app')
        expect(response.body).to include(token)
      end

      context 'as the wrong user' do
        before { session[:user_id] = bob.id }

        it 'redirects with a flash alert' do
          get :new, params: proof_params

          expect(flash[:alert]).not_to be_empty
          expect(response).to redirect_to(Rails.application.routes.url_helpers.root_path)
        end

        it 'uses the overridden flash message in the inherited base controller' do
          get :new, params: proof_params

          expect(flash[:alert]).to eq 'overridden you\'re logged in as bob but trying to prove alice'
        end
      end
    end
  end
end
