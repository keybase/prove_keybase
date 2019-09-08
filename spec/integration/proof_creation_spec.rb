# frozen_string_literal: true

require 'rails_helper'

def sign_in_as(user)
  post sessions_url, params: { username: user.username, password: user.password }
end

RSpec.describe 'Proof Creation', type: :request, order: :defined do
  include ActiveJob::TestHelper

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

  let(:proof_valid_url) do
    uri = URI.parse('https://keybase.io/_/api/1.0/sig/proof_valid.json')
    params = {
      domain: domain,
      kb_username: kb_username,
      sig_hash: '1' * 66,
      username: username
    }
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end

  let(:proof_live_url) do
    uri = URI.parse('https://keybase.io/_/api/1.0/sig/proof_live.json')
    params = {
      domain: domain,
      kb_username: kb_username,
      sig_hash: '1' * 66,
      username: username
    }
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end

  let(:fetch_keybase_avatar_url) do
    uri = URI.parse('https://keybase.io/_/api/1.0/user/pic_url.json')
    uri.query = URI.encode_www_form(username: kb_username)
    uri.to_s
  end

  let(:keybase_avatar_url) do
    'https://keybase.io/images/icons/icon-keybase-logo-64@2x.png'
  end

  def keybase_proof_live_response(request)
    # dumbed-down version of what keybase is actually doing
    # to determine whether or not a proof is "live"
    username = request.uri.query_values['username']
    get "/prove_keybase/api/v1/proofs?username=#{username}"

    local_api_response = JSON.parse(response.body)['signatures']
    proof_live = (local_api_response == [{ 'sig_hash' => token, 'kb_username' => kb_username }])
    "{\"proof_valid\":true,\"proof_live\":#{proof_live}}"
  end

  it 'happy path' do
    alice = User.create!(username: username, password: '1234567')
    sign_in_as(alice)

    stub_request(:get, fetch_keybase_avatar_url).to_return(body: "{\"pic_url\":\"#{keybase_avatar_url}\"}")
    get '/prove_keybase/proofs/new', params: proof_params
    expect(response.body).to include('overridden by the dummy app')

    # keybase should say that the proof is "proof_valid" right away
    # but "proof_live" only after it's noticed it through the local api
    stub_request(:get, proof_valid_url).to_return(body: '{"proof_valid":true}')
    stub_request(:get, proof_live_url)
      .to_return(body: '{"proof_valid":true,"proof_live":false}').then
      .to_return(body: ->(request) { keybase_proof_live_response(request) })
    perform_enqueued_jobs do
      post '/prove_keybase/proofs', params: { proof: proof_params }
      expect(response.status).to eq(302)
    end

    expect(alice.keybase_proofs.first.proof_live).to be true
  end
end
