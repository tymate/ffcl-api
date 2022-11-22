# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'mutation type'

    field :register, mutation: Mutations::Register
    field :create_club, mutation: Mutations::CreateClub
    field :join_club, mutation: Mutations::JoinClub
    field :update_club, mutation: Mutations::UpdateClub
  end
end
