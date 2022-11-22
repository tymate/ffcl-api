# frozen_string_literal: true

module Mutations
  class CreateReadingSession < BaseMutation
    description 'Create a new reading session'

    argument :name, String, required: true
    argument :club_id, ID, required: true, loads: Types::ClubType

    field :reading_session, Types::ReadingSessionType, null: true

    def resolve(club:, **args)
      authorize! club, to: :create_session?
      reading_session = club.reading_sessions.create!(args)

      { reading_session: }
    end
  end
end
