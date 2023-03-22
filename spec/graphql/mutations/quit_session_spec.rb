# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'quitSession' }
  let(:book) { Fabricate(:book) }
  let(:reading_session) { Fabricate(:reading_session_with_selected_book) }
  let(:variables) do
    {
      input: {
        readingSessionId: id_from_object(reading_session)
      }
    }
  end

  it_behaves_like 'with standard user' do
    context 'when the user is a member' do
      it 'quits the session' do
        reading_session.users << user
        expect { do_graphql_request }.to(change { reading_session.reload.users.count }.by(-1))
      end
    end

    context 'when the user is not a member' do
      before do
        reading_session.users.delete(user)
        reading_session.reload
      end

      it "doesn't quit the session" do
        expect { do_graphql_request }.not_to(change { reading_session.users.count })
      end
    end
  end
end
