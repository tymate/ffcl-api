# frozen_string_literal: true

RSpec.shared_examples 'when unauthenticated' do
  it 'returns an error' do
    expect(errors).to be_present
    expect(errors.dig(0, 'extensions', 'code')).to eq('unauthorized')
  end
end
