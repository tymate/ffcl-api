# frozen_string_literal: true

module Mutations
  class CreateReview < Mutations::BaseMutation
    description 'Create a new review'

    argument :rating, Integer, required: true
    argument :comment, String, required: false
    argument :reading_session_id, ID, required: true, loads: Types::ReadingSessionType
    argument :book_id, ID, required: true, loads: Types::BookType
    argument :user_id, ID, required: true, loads: Types::UserType

    field :review, Types::ReviewType, null: true

    def resolve(book:, user:, reading_session:, **args)
      authorize! reading_session, to: :create_review?
      review = reading_session.reviews.create!(args.merge(user:, book:))

      { review: }
    end
  end
end
