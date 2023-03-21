# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutatationType, type: :request do
  let(:query) { 'deleteSession' }
  let(:reading_session) { Fabricate(:reading_session) }

  let(:variables) do
    {
      input: {
        readingSessionId: id_from_object(reading_session)
      }
    }
  end

  before { do_graphql_request }
end

