# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'mutation type'

    field :register, mutation: Mutations::Register
    field :create_club, mutation: Mutations::CreateClub
    field :join_club, mutation: Mutations::JoinClub
    field :update_club, mutation: Mutations::UpdateClub
    field :create_reading_session, mutation: Mutations::CreateReadingSession
  end
end
