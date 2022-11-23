# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'deleteClub' }
  let(:user) { Fabricate(:user) }
  let(:club) { Fabricate(:club, admin: user) }

  let(:variables) do
    {
      input: {
        id: club.id
      }
    }
  end

  before { do_graphql_request }

  context 'when authenticated and admin of the club' do
    it_behaves_like 'with standard user' do
      it 'deletes a club' do
        expect(errors).to be_blank
        data = json.dig('data', 'deleteClub', 'club')
        expect(data).not_to be_empty
        expect { club.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when authenticated but not admin of the club' do
    let(:club) { Fabricate(:club, admin: Fabricate(:user)) }

    it_behaves_like 'with standard user' do
      it 'does not delete a club' do
        expect(errors).not_to be_blank
        error = json.dig('errors', 0, 'message')
        expect(error).to eq('You are not authorized to perform this action')
        expect { club.reload }.not_to raise_error
        expect(club).to be_present
      end
    end
  end

  include_examples 'when unauthenticated'
end
