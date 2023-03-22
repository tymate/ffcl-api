# frozen_string_literal: true

module Mutations
  class JoinSession < BaseMutation
    description 'Join a session'

    argument :reading_session_id, ID, required: true, loads: Types::ReadingSessionType

    field :reading_session, Types::ReadingSessionType, null: true

    def resolve(reading_session:)
      authorize! reading_session, to: :join?
      reading_session.users << current_user

      { reading_session: }
    end
  end
end
