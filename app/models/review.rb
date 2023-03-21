# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :reading_session
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  }
  validates :comment, length: { maximum: 255 }
end

# == Schema Information
#
# Table name: reviews
#
#  id                 :bigint           not null, primary key
#  comment            :text
#  rating             :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  book_id            :bigint           not null
#  reading_session_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_reviews_on_book_id             (book_id)
#  index_reviews_on_reading_session_id  (reading_session_id)
#  index_reviews_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (reading_session_id => reading_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
