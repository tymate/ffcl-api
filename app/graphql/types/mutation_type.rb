# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'mutation type'

    field :register, mutation: Mutations::Register
    field :create_club, mutation: Mutations::CreateClub
    field :join_club, mutation: Mutations::JoinClub
    field :create_reading_session, mutation: Mutations::CreateReadingSession
    field :invitation_club, mutation: Mutations::InvitationClub
  end
end
