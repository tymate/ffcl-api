# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrawBookJob do
  let(:club) { Fabricate(:club) }
  let(:previous_reading_session) { Fabricate(:reading_session, club:, state: 'conclusion') }
  let(:reading_session) { Fabricate(:reading_session, club:, state: 'draw') }
  let(:propositions) do
    Fabricate.times(5, :proposition,
                    reading_session:)
  end

  before do
    propositions
    previous_reading_session
  end

  context 'when state is `draw`' do
    it 'selects a book randomly' do
      described_class.perform_now(reading_session.id)
      expect(reading_session.reload.selected_book).not_to be_nil
    end

    it 'changes state from `draw` to `reading`' do
      described_class.perform_now(reading_session.id)
      expect(reading_session.reload.state).to eq('reading')
    end
  end
end
