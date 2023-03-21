# frozen_string_literal: true

module Mutations
  class DeleteSession < BaseMutation
    description 'Delete a session'

    argument :reading_session_id, ID, required: true, loads: Types::ReadingSessionType

    field :deleted, Boolean, null: false

    def resolve(reading_session:)
      authorize! reading_session, to: :destroy?
      reading_session.destroy!

      { deleted: true }
    end
  end 
end
