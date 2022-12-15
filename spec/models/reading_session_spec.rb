# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingSession do
  context 'with valid attributes' do
    let(:reading_session) { Fabricate(:reading_session) }

    it 'is valid' do
      expect(reading_session).to be_valid
    end

    it 'changes state to draw' do
      reading_session.start_draw
      expect(reading_session).to be_draw
    end

    it 'changes state to reading' do
      reading_session.start_draw
      reading_session.start_reading
      expect(reading_session).to be_reading
    end

    it 'changes state to conclusion' do
      reading_session.start_draw
      reading_session.start_reading
      reading_session.conclude
      expect(reading_session).to be_conclusion
    end

    it 'changes state to archived' do
      reading_session.start_draw
      reading_session.start_reading
      reading_session.conclude
      reading_session.archive
      expect(reading_session).to be_archived
    end
  end

  context 'with invalid submission_due_date' do
    let(:reading_session) { Fabricate(:reading_session, submission_due_date: 2.days.ago) }

    it 'is not valid' do
      expect { reading_session }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'with invalid read_due_date' do
    let(:reading_session) do
      Fabricate(:reading_session,
                submission_due_date: 5.days.from_now,
                read_due_date: 2.days.from_now)
    end

    it 'is not valid' do
      expect { reading_session }.to raise_error(ActiveRecord::RecordInvalid)
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
#  selected_book_id    :bigint
#
# Indexes
#
#  index_reading_sessions_on_club_id           (club_id)
#  index_reading_sessions_on_selected_book_id  (selected_book_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (selected_book_id => books.id)
#
