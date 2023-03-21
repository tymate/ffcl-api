# frozen_string_literal: true

module Mutations
  class QuitSession < BaseMutation
    description 'Quit a session'

    argument :session_id, ID, required: true, loads: Types::ReadingSessionType

    field :deleted, Boolean, null: false

    def resolve(session:)
      authorize! ReadingSession, to: :quit?

      session.users.delete(current_user) if session.users.include?(current_user)

      { deleted: }
    end
  end
end
