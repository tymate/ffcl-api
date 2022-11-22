# frozen_string_literal: true

module Types
  class ReadingSessionType < Types::BaseType
    description 'A reading session'

    field :id, ID, null: false
    field :name, String, null: false
  end
end
