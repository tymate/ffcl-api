# frozen_string_literal: true

module Types
  class ClubType < Types::BaseType
    description 'A club'

    field :id, ID, null: false
    field :label, String, null: false
    field :description, String, null: false
    field :admin, Types::UserType
    field :invitation_code, String, null: false
  end
end
