# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'mutation type'

    field :register, mutation: Mutations::Register
    field :create_club, mutation: Mutations::CreateClub
    field :invitation_club, mutation: Mutations::InvitationClub
    field :join_club, mutation: Mutations::JoinClub
    field :update_club, mutation: Mutations::UpdateClub
    field :delete_club, mutation: Mutations::DeleteClub
    field :create_reading_session, mutation: Mutations::CreateReadingSession
    field :submit_book, mutation: Mutations::SubmitBook
    field :quit_club, mutation: Mutations::QuitClub
    field :invite_user, mutation: Mutations::InviteUser
    field :create_review, mutation: Mutations::CreateReview
    field :quit_session, mutation: Mutations::QuitSession
  end
end
