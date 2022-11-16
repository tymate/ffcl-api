# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'createReadingSession' }
  let(:club) { Fabricate(:club) }
  let(:variables) do
    {
      input: {
        clubId: club.to_sgid.to_s,
        name: Faker::Lorem.word
      }
    }
  end

  it_behaves_like 'with standard user' do
    it 'creates a new session' do
      do_graphql_request
      binding.pry
    end
  end

  describe 'when unauthenticated' do
    before do
      do_graphql_request
    end

    include_examples 'when unauthenticated'
  end
end
