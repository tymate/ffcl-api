# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe 'currentUser' do
    let(:query) { 'fullDetailsReadingSession' }
    let(:variables) { { sessionId: id_from_object(reading_session) } }

    let(:club) do
      Fabricate(:club).tap { _1.users << Fabricate.times(5, :user) }
    end
    let(:reading_session) do
      Fabricate(:reading_session, club:).tap do |reading_session|
        club.users.each do |club_user|
          Fabricate(:proposition, reading_session:, user: club_user)
        end
      end
    end

    it_behaves_like 'with standard user' do
      before { club.users << user }

      it 'returns details of the reading session' do
        do_graphql_request

        expect(errors).to be_blank
        expect(json.dig('data', 'readingSession', 'propositions', 'totalCount'))
          .to eq(reading_session.propositions.count)
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
