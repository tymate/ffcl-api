# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'joinClub' }
  let(:club) { Fabricate(:club) }
  let(:variables) do
    {
      input: {
        invitationCode: club.invitation_code
      }
    }
  end

  it_behaves_like 'with standard user' do
    it 'joins the club' do
      expect { do_graphql_request }.to change(club.users, :count).by(1)
    end

    context 'when the user is already a member' do
      before do
        club.users << user
        club.reload
      end

      it "doesn't join the club" do
        expect { do_graphql_request }.to_not change { club.users.count }
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
