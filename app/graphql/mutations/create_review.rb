# frozen_string_literal: true

module Mutations
  class CreateReview < Mutations::BaseMutation
    description 'Create a new review'

    argument :rating, Integer, required: true
    argument :comment, String, required: false
    argument :reading_session_id, ID, required: true, loads: Types::ReadingSessionType

    field :review, Types::ReviewType, null: true

    def resolve(reading_session:, **args)
      authorize! reading_session, to: :create_review?

      review = reading_session.reviews.find_or_initialize_by(
        user: current_user,
        book: reading_session.selected_book
      )
      review.update!(args)
      review.save

      { review: }
    end
  end
end
