# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'updateClub' }
  let(:user) { Fabricate(:user) }
  let(:club) { Fabricate(:club, admin: user) }
  let(:variables) do
    {
      input: {
        id: club.id,
        label: 'New label'
      }
    }
  end

  context 'when user is admin' do
    it_behaves_like 'with standard user' do
      it 'updates a club' do
        do_graphql_request
        expect(club.reload.label).to eq('New label')
      end
    end
  end

  context 'when user is not admin' do
    let(:another_user) { Fabricate(:user) }

    it 'does not update a club' do
      do_graphql_request
      data = JSON.parse(response.body)['errors']
      expect(data[0]['message']).to be_present
    end
  end

  describe 'when unauthenticated' do
    before do
      do_graphql_request
    end

    include_examples 'when unauthenticated'
  end
end
