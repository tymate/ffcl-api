# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  let(:query) { 'clubs' }
  let(:data) { json.dig('data', 'clubs', 'nodes') }

  before { do_graphql_request }

  it_behaves_like 'with standard user' do
    describe 'clubs' do
      before do
        clubs = Fabricate.times(2, :club)
        Fabricate.times(3, :club)
        clubs.each do |club|
          club.users << user
        end
        user.reload
        do_graphql_request
      end

      context 'when I want user clubs' do
        let(:variables) do
          {
            myClubs: true
          }
        end

        it "get clubs where I'm a member" do
          expect(errors).to be_blank
          expect(json.dig('data', 'clubs', 'nodes').size).to eq(2)
        end
      end

      context 'when I want other clubs' do
        let(:variables) do
          {
            otherClubs: true
          }
        end

        it "get clubs where I'm a member" do
          expect(errors).to be_blank
          expect(json.dig('data', 'clubs', 'nodes').size).to eq(3)
        end
      end
    end
  end

  include_examples 'when unauthenticated'
end
