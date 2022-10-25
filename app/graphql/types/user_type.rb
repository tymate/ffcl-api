# frozen_string_literal: true

module Types
  class UserType < Types::BaseType
    description 'A user'

    field :email, String, null: false
    field :username, String, null: false
  end
end
