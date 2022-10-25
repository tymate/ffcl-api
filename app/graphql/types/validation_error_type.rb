# frozen_string_literal: true

module Types
  class ValidationErrorType < Types::BaseObject
    description 'The validation error type'

    field :path, [String], null: false
    field :message, String, null: false
    field :attributes, String, null: false
    field :error, String, null: true
  end
end
