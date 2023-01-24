# frozen_string_literal: true

module Types
  class ReadingSessionType < Types::BaseType
    description 'A reading session'

    global_id_field :id
    field :club, Types::ClubType, null: false
    field :state, String, null: false
    field :selected_book, Types::BookType, null: true
    field :name, String, null: false
    field :submission_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :read_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :users, Types::UserType.connection_type, null: false
  end
end
