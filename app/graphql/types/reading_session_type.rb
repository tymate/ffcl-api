# frozen_string_literal: true

module Types
  class ReadingSessionType < Types::BaseType
    description 'A reading session'

    field :id, ID, null: false
    field :name, String, null: false
    field :submission_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :read_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :next_step_date, GraphQL::Types::ISO8601DateTime, null: true
    field :propositions, Types::PropositionType.connection_type, null: true
    field :selected_book, Types::BookType, null: true
    field :selected_book_submitters, Types::UserType.connection_type, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
