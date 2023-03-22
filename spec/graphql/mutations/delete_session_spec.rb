# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'deleteSession' }
  let(:user) { Fabricate(:user) }
  let(:club) { Fabricate(:club, admin: user) }
  let(:reading_session) { Fabricate(:reading_session, club:) }
  let(:variables) do
    {
      input: {
        readingSessionId: id_from_object(reading_session)
      }
    }
  end

  before { do_graphql_request }

  context 'when authenticated and admin of the club' do
    it_behaves_like 'with standard user' do
      it 'deletes a session' do
        expect(errors).to be_blank
        data = json.dig('data', 'deleteSession', 'deleted')
        expect(data).to be_truthy
        expect { reading_session.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when authenticated but not admin of the club' do
    let(:reading_session) { Fabricate(:reading_session, club: Fabricate(:club, admin: Fabricate(:user))) }

    it_behaves_like 'with standard user' do
      it 'does not delete a session' do
        expect(errors).not_to be_blank
        error = json.dig('errors', 0, 'message')
        expect(error).to eq('You are not authorized to perform this action')
        expect { reading_session.reload }.not_to raise_error
        expect(reading_session).to be_present
      end
    end
  end

  include_examples 'when unauthenticated'
end
