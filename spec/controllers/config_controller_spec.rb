# frozen_string_literal: true

require 'rails_helper'

describe ProveKeybase::ConfigController, type: :controller do
  routes { ProveKeybase::Engine.routes }
  render_views

  describe 'GET #show' do
    it 'renders json' do
      get :show

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/json'
      expect { JSON.parse(response.body) }.not_to raise_exception
    end

    it 'pulls through configs from the initializer' do
      get :show

      config = JSON.parse(response.body)
      expect(config['profile_url']).to eq 'https://example.test/users/%{username}'
      expect(config['check_url']).to eq "https://example.test/prove_keybase/api/v1/proofs/%{username}"
    end
  end
end
