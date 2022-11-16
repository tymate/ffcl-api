# frozen_string_literal: true

module Mutations
  class CreateReadingSession < BaseMutation
    description 'Create a new reading session'

    argument :name, String, required: true
    argument :club_id, ID, required: true, loads: Types::ClubType

    field :reading_session, Types::ReadingSessionType, null: true

    def resolve(club:, **args)
      binding.pry
      authorize! club, to: :create_session?
      ReadingSession.create!(args)

      { reading_session: }
    end
  end
end
