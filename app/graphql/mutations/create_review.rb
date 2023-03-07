# frozen_string_literal: true

module Mutations
  class CreateReview < Mutations::BaseMutation
    argument :rating, Integer, required: true
    argument :comment, String, required: false
    argument :reading_session_id, ID, required: true

    field :review, Types::ReviewType, null: true
    field :errors, [String], null: false

    def resolve(rating:, comment:, reading_session_id:)
      reading_session = ReadingSession.find(reading_session_id)
      review = Review.new(rating:, comment:, reading_session:, user: context[:current_user])
      if review.save
        {
          review:,
          errors: []
        }
      else
        {
          review: nil,
          errors: review.errors.full_messages
        }
      end
    end
  end
end
