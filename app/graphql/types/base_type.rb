# frozen_string_literal: true

module Types
  class BaseType < Types::BaseObject
    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
