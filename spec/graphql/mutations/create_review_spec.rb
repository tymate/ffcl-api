# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'createReview' }
  let(:club) { Fabricate(:club_with_users) }
  let(:reading_session) { Fabricate(:reading_session_with_selected_book) }
  let(:book) { Fabricate(:book) }

  let(:variables) do
    {
      input: {
        readingSessionId: id_from_object(reading_session),
        rating: 5,
        comment: Faker::Lorem.sentence
      }
    }
  end

  it_behaves_like 'with standard user' do
    describe 'when the user is part of the club' do
      before do
        club.users << user
      end

      it 'creates a new review' do
        do_graphql_request
        expect(Review.count).to eq(1)
        expect(json.dig('data', query, 'review', 'rating')).to eq(5)
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
