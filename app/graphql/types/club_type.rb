# frozen_string_literal: true

module Types
  class ClubType < Types::BaseType
    description 'A club'

    field :id, ID, null: false
    field :label, String, null: false
    field :description, String, null: false
    field :club_admin, Types::UserType
    field :invitation_code, Integer, null: false
    field :users, [Types::UserType], null: false
  end
end
