# frozen_string_literal: true

module Types
  class ClubType < Types::BaseType
    description 'A club'

    global_id_field :id
    field :label, String, null: false
    field :description, String, null: false
    field :admin, Types::UserType
    field :invitation_code, String, null: false
    field :users, Types::UserType.connection_type, null: false
    field :current_reading_sessions, Types::ReadingSessionType.connection_type, null: false
    field :previous_reading_sessions, Types::ReadingSessionType.connection_type, null: false

    def current_reading_sessions
      object.reading_sessions.where.not(state: %w[conclusion archived])
    end

    def previous_reading_sessions
      object.reading_sessions.where(state: %w[conclusion archived])
    end
  end
end
