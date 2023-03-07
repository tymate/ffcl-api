# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'review' }
  let(:book) { Fabricate(:book) }
  let(:reading_session) { Fabricate(:reading_session, book:) }
  let(:variables) do
    {
      input: {
        readingSessionId: reading_session.id,
        rating: 5,
        comment: Faker::Lorem.sentence
      }
    }
  end

  it_behaves_like 'with standard user' do
    it 'creates a new review' do
      expect { do_graphql_request }.to change(Review, :count).by(1)
    end
  end

  describe 'when unauthenticated' do
    before do
      do_graphql_request
    end

    include_examples 'when unauthenticated'
  end
end