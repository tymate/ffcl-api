# frozen_string_literal: true

require 'acceptance_helper'

resource 'OAuth Tokens' do
  explanation 'Doorkeeper Tokens resource'

  header 'Accept',       'application/json'
  header 'Content-Type', 'application/json'

  context 'with `password` grant flow' do
    let(:doorkeeper_application) { Fabricate(:application) }
    let(:user) { Fabricate(:user, password: 'password') }

    post '/api/v1/oauth/token' do
      with_options required: true, with_example: true do
        parameter :client_id, 'Client UID to connect to app'
        parameter :grant_type, 'Oauth grant type'
        parameter :username, 'User email'
        parameter :password, 'User password'
      end

      let(:client_id) { doorkeeper_application.uid }
      let(:grant_type) { 'password' }
      let(:username) { user.email }
      let(:password) { 'password' }

      let(:raw_post) { params.to_json }

      example 'Get a new token with `password` grant flow' do
        do_request
        expect(status).to eq(200)
        response = JSON.parse(response_body)
        expect(response['access_token']).not_to be_blank
        expect(response['refresh_token']).not_to be_blank
      end

      context 'with invalid credentials', document: false do
        let(:password) { 'wrong_password' }

        it 'returns an error' do
          do_request
          expect(status).to eq(400)
          expect(JSON.parse(response_body)['error']).to eq('invalid_grant')
        end
      end
    end
  end
end
