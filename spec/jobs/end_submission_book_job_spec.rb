# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EndSubmissionBookJob do
  let(:reading_session) { Fabricate(:reading_session) }

  before do
    reading_session.update(submission_due_date: Time.zone.now)
    allow(DrawBookJob).to receive(:perform_later)
  end

  context 'when submission due date is reached' do
    it 'changes status from submission to draw' do
      described_class.perform_now(reading_session.id)

      expect(reading_session.reload.state).to eq('draw')
      expect(DrawBookJob).to have_received(:perform_later).once
    end
  end
end
