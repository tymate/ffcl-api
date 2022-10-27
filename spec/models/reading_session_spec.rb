# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingSession do
  context 'with valid attributes' do
    let(:reading_session) { Fabricate(:reading_session) }

    it 'is valid' do
      expect(reading_session).to be_valid
    end

    it 'changes state to draw' do
      reading_session.submit
      expect(reading_session).to be_draw
    end

    it 'changes state to reading' do
      reading_session.submit
      reading_session.draw
      expect(reading_session).to be_reading
    end

    it 'changes state to conclusion' do
      reading_session.submit
      reading_session.draw
      reading_session.complete
      expect(reading_session).to be_conclusion
    end

    it 'changes state to archived' do
      reading_session.submit
      reading_session.draw
      reading_session.complete
      reading_session.archive
      expect(reading_session).to be_archived
    end
  end
end

# == Schema Information
#
# Table name: reading_sessions
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  next_step_date      :datetime
#  read_due_date       :datetime
#  state               :string           default("submission"), not null
#  submission_due_date :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  club_id             :bigint           not null
#
# Indexes
#
#  index_reading_sessions_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#
