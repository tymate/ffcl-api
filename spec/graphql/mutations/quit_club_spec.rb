# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'quitClub' }
  let(:club) { Fabricate(:club_with_users) }
  let(:variables) do
    {
      input: {
        clubId: id_from_object(club)
      }
    }
  end

  it_behaves_like 'with standard user' do
    context 'when the user is a member' do
      before do
        club.users << user
        club.reload
      end

      it 'quits the club' do
        expect { do_graphql_request }.to(change { club.users.count }.by(-1))
      end
    end

    context 'when the user is not a member' do
      before do
        club.users.delete(user)
        club.reload
      end

      it "doesn't quit the club" do
        expect { do_graphql_request }.not_to(change { club.users.count })
      end
    end
  end
end
