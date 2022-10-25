# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe 'currentUser' do
    let(:query) { 'currentUser' }

    it_behaves_like 'with standard user' do
      it 'get details of the current user' do
        do_graphql_request

        expect(errors).to be_blank

        data = json.deep_symbolize_keys.dig(:data, :currentUser)
        expect(data).to include(:email)

        expect(data[:email]).to eq(user.email)
      end

      context 'when token is expired' do
        before do
          token.update!(expires_in: 0)
          do_graphql_request
        end

        it 'returns a localized error' do
          expect(errors).to be_present
          expect(errors.dig(0, 'message')).to match(/The access token expired/)
          expect(errors.dig(0, 'extensions', 'code')).to eq('unauthorized')
        end
      end

      context 'when token is revoked' do
        before do
          token.revoke
          do_graphql_request
        end

        it 'returns a localized error' do
          expect(errors).to be_present
          expect(errors.dig(0, 'message')).to match(/The access token was revoked/)
          expect(errors.dig(0, 'extensions', 'code')).to eq('unauthorized')
        end
      end
    end

    describe 'when unauthenticated' do
      before do
        do_graphql_request
      end

      include_examples 'when unauthenticated'
    end
  end
end
