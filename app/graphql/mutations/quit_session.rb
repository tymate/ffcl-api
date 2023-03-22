# frozen_string_literal: true

module Mutations
  class QuitSession < BaseMutation
    description 'Quit a session'

    argument :reading_session_id, ID, required: true, loads: Types::ReadingSessionType

    field :reading_session, Types::ReadingSessionType, null: true

    def resolve(reading_session:)
      authorize! reading_session, to: :quit?
      reading_session.users.delete(current_user)

      { reading_session: }
    end
  end
end
