# frozen_string_literal: true

Fabricator(:reading_session) do
  name { Faker::Book.title }
  submission_due_date { 1.day.from_now }
  read_due_date { 2.days.from_now }
  club
end

Fabricator(:reading_session_with_selected_book, from: :reading_session) do
  state { 'reading' }
  selected_book { Fabricate(:book) }
end

# club
# name                { Faker::Lorem.word }
# next_step_date      nil
# read_due_date       { 1.month.from_now }
# submission_due_date { 10.days.from_now }
# state { 'submission' }

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
