# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'joinSession' }
  let(:club) { Fabricate(:club_with_users) }
  let(:reading_session) { Fabricate(:reading_session_with_submission_state, club:) }
  let(:proposition) { Fabricate(:proposition, reading_session:) }
  let(:variables) do
    {
      input: {
        readingSessionId: id_from_object(reading_session)
      }
    }
  end

  it_behaves_like 'with standard user' do
    context 'when the user is not part of the session' do
      it 'joins the session' do
        expect do
          do_graphql_request
          reading_session.propositions.reload
          proposition.reading_session.reload
        end.to(change { reading_session.users.count }.by(1))
      end
    end
  end
end
