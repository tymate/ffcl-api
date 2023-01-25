# frozen_string_literal: true

class ReadingSession < ApplicationRecord
  belongs_to :club
  belongs_to :selected_book, class_name: 'Book', optional: true

  # has_many :reviews, dependent: :destroy, inverse_of: :reading_session
  has_many :propositions, dependent: :destroy, inverse_of: :reading_session
  has_many :books, through: :propositions
  has_many :users, through: :club

  validates :name, :state,
            :submission_due_date, :read_due_date,
            presence: true

  validates :submission_due_date,
            comparison: { greater_than: Time.zone.now }

  validates :read_due_date,
            comparison: { greater_than: :submission_due_date }

  state_machine :state, initial: :submission do
    state :submission, :draw, :reading, :conclusion, :archived

    event :start_draw do
      transition submission: :draw
    end

    event :start_reading do
      transition draw: :reading
    end

    event :conclude do
      transition reading: :conclusion
    end

    event :archive do
      transition conclusion: :archived
    end

    after_transition submission: :draw do |reading_session|
      DrawBookJob.perform_later(reading_session.id)
    end

    after_transition draw: :reading do |reading_session|
      ConcludeReadingSessionJob.set(wait_until: reading_session.read_due_date)
                               .perform_later(reading_session.id)
    end
  end

  def next_step_date
    case state
    when 'submission'
      submission_due_date
    when 'draw', 'reading'
      read_due_date
    end
  end

  def selected_book_submitters
    return if %w[submission draw].include?(state)

    User.joins(:propositions).where(propositions: { session: self, book: selected_book })
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
