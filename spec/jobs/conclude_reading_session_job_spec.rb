# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConcludeReadingSessionJob do
  let(:reading_session) { Fabricate(:reading_session, state: 'reading') }

  before do
    reading_session.update(read_due_date: Time.zone.now)
  end

  context 'when read due date is reached' do
    it 'changes status from reading to conclusion' do
      described_class.perform_now(reading_session.id)

      expect(reading_session.reload.state).to eq('conclusion')
    end
  end
end
