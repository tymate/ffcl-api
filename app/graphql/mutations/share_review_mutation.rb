# frozen_string_literal: true

module Mutations
  class ShareReview < BaseMutation
    description 'Share a review'

    argument :reading_session, Types::ReadingSessionType, required: true

    field :review, Types::ReviewType, null: true

    def resolve(reading_session:)
      return unless reading_session.state == 'conclusion'
      unless reading_session.users.include?(current_user)
        raise GraphQL::ExecutionError, 'You are not part of this reading session'
      end

      review = Review.find_by(reading_session:, user: current_user)
      review.update(share: true)
      { review: }
    end
  end
end
