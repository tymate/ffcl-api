# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'register' }
  let(:variables) do
    {
      input: {
        email: Faker::Internet.email,
        username: Faker::Internet.username,
        password: Faker::Internet.password
      }
    }
  end

  context 'when user creates a new account' do
    it 'creates a new user' do
      expect { do_graphql_request }.to change(User, :count).by(1)
    end
  end
end
