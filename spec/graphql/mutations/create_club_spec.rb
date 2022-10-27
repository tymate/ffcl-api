# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'createClub' }
  let(:variables) do
    {
      input: {
        label: Faker::Lorem.word,
        description: Faker::Lorem.sentence
      }
    }
  end

  it_behaves_like 'with standard user' do
    it 'creates a new club' do
      expect { do_graphql_request }.to change(Club, :count).by(1)
    end
  end
end
