# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'createReadingSession' }
  let(:club) { Fabricate(:club) }
  let(:name) { Faker::Lorem.word }
  let(:variables) do
    {
      input: {
        clubId: id_from_object(club),
        name:,
        submissionDueDate: 10.days.from_now,
        readDueDate: 1.month.from_now
      }
    }
  end

  it_behaves_like 'with standard user' do
    describe "when the user isn't the admin of the club" do
      it 'returns an error' do
        do_graphql_request
        expect(errors.dig(0, 'extensions', 'code')).to eq('forbidden')
      end
    end

    describe 'when the user is the admin of the club' do
      let(:club) { Fabricate(:club, admin: user) }

      it 'creates a new session' do
        expect { do_graphql_request }.to change(club.reload.reading_sessions, :count).by(1)

        binding.pry

        expect(json.dig('data', query, 'readingSession', 'name')).to eq(name)
      end

      context 'when a active reading_session already exists' do
        before do
          Fabricate(:reading_session, club:)
        end

        it 'returns an error' do
          do_graphql_request
          expect(errors.dig(0, 'extensions', 'code')).to eq('forbidden')
        end
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
