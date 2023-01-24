# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  let(:query) { 'club' }
  let(:club) { Fabricate(:club) }
  let(:data) { json.dig(:data, :club) }

  before { do_graphql_request }

  it_behaves_like 'with standard user' do
    let(:variables) do
      {
        clubId: id_from_object(club)
      }
    end

    context 'when I want a club' do
      it 'get a club' do
        data = json.deep_symbolize_keys.dig(:data, :club)
        expect(errors).to be_blank
        expect(data).to include(:label)
        expect(data[:label]).to eq(club.label)
      end
    end

    context 'when I want a club with users' do
      let(:variables) do
        {
          clubId: id_from_object(club)
        }
      end

      it 'get a club with users' do
        data = json.deep_symbolize_keys.dig(:data, :club)
        expect(errors).to be_blank
        expect(data).to include(:label)
        expect(data[:label]).to eq(club.label)
        expect(data[:users]).to be_present
      end
    end
  end
end
