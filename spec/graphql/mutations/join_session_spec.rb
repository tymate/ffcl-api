# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'joinSession' }
  let(:club) { Fabricate(:club_with_users) }
  let(:reading_session) { Fabricate(:reading_session_with_propositions, club:) }
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
        do_graphql_request
        expect do
          reading_session.propositions.reload
          proposition.reading_session.reload
        end.to(change { reading_session.users.count }.by(1))
        expect(reading_session.users).to include(user)
      end
    end

    context 'when user is already a member' do
      before do
        reading_session.users << user
        reading_session.reload
      end

      it "doesn't quit the the session" do
        expect { do_graphql_request }.not_to(change { reading_session.users.count })
      end
    end
  end
end
