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
