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
    field :reading_sessions, Types::ReadingSessionType.connection_type, null: false
    field :current_reading_session, Types::ReadingSessionType, null: true
    field :previous_reading_session, Types::ReadingSessionType.connection_type, null: false

    def current_reading_session
      object.reading_sessions.where(state: %w[submission draw reading]).first
    end

    def previous_reading_session
      object.reading_sessions.where(state: %w[conclusion archived]).all
    end
  end
end
