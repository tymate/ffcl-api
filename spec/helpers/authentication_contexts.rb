# frozen_string_literal: true

RSpec.shared_context 'with standard user' do
  let(:application) { Fabricate(:application) }
  let(:user)  { Fabricate(:user) }
  let(:token) { Fabricate(:token, user:, application:, scopes: :app) }
  let(:headers) { { Authorization: "Bearer #{token.token}" } }
end
