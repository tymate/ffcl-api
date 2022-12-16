# frozen_string_literal: true

module Types
  class PropositionType < Types::BaseType
    description 'User book proposition'

    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :book, Types::BookType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
