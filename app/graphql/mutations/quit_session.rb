# frozen_string_literal: true

module Mutations
  class QuitSession < BaseMutation
    description 'Quit a session'

    argument :session_id, ID, required: true, loads: Types::ReadingSessionType

    field :session, Types::ReadingSessionType, null: true

    def resolve(session:)
      authorize! User, to: :quit_session?

      session.users.delete(current_user) if session.users.include?(current_user)

      { session: }
    end
  end
end
