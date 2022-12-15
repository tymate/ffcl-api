# frozen_string_literal: true

module Types
  class ReadingSessionType < Types::BaseType
    description 'A reading session'

    field :id, ID, null: false
    field :name, String, null: false
    field :submission_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :read_due_date, GraphQL::Types::ISO8601DateTime, null: false
  end
end
