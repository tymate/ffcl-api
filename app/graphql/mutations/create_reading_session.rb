# frozen_string_literal: true

module Mutations
  class CreateReadingSession < BaseMutation
    description 'Create a new reading session'

    argument :name, String, required: true
    argument :submission_due_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :read_due_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :club_id, ID, required: true, loads: Types::ClubType

    field :reading_session, Types::ReadingSessionType, null: true

    def resolve(club:, **args)
      authorize! club, to: :create_session?
      reading_session = club.reading_sessions.create!(args)

      # Change session state when submission due date is reached
      EndSubmissionBookJob.set(wait_until: reading_session.submission_due_date).perform_later(reading_session.id)

      { reading_session: }
    end
  end
end
