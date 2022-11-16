# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'createReadingSession' }
  let(:club) { Fabricate(:club) }
  let(:name) { Faker::Lorem.word }
  let(:variables) do
    {
      input: {
        clubId: club.to_sgid.to_s,
        name:
      }
    }
  end

  it_behaves_like 'with standard user' do
    context "when the user isn't the admin of the club" do
      it 'return an error' do
        do_graphql_request
        expect(errors.dig(0, 'extensions', 'code')).to eq('forbidden')
      end
    end

    context 'when the user is the admin of the club' do
      let(:club) { Fabricate(:club, admin: user) }

      it 'creates a new session' do
        expect { do_graphql_request }.to change(club.reload.reading_sessions, :count).by(1)
        expect(json.dig('data', query, 'readingSession', 'name')).to eq(name)
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
