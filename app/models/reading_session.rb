# frozen_string_literal: true

class ReadingSession < ApplicationRecord
  belongs_to :club
  # belongs_to :selected_book, class_name: 'Book', optional: true

  # has_many :reviews, dependent: :destroy, inverse_of: :reading_session
  # has_many :reading_session_books, dependent: :destroy, inverse_of: :reading_session
  # has_many :books, through: :reading_session_books
  validates :name, :state, presence: true

  state_machine :state, initial: :submission do
    state :submission, :draw, :reading, :conclusion, :archived

    event :submit do
      transition submission: :draw
    end

    event :draw do
      transition draw: :reading
    end

    event :complete do
      transition reading: :conclusion
    end

    event :archive do
      transition conclusion: :archived
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
