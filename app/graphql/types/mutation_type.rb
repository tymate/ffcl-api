# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'mutation type'

    # general
    field :register, mutation: Mutations::Register
    field :invite_user, mutation: Mutations::InviteUser

    # club
    field :create_club, mutation: Mutations::CreateClub
    field :update_club, mutation: Mutations::UpdateClub
    field :quit_club, mutation: Mutations::QuitClub
    field :join_club, mutation: Mutations::JoinClub
    field :delete_club, mutation: Mutations::DeleteClub
    field :invitation_club, mutation: Mutations::InvitationClub

    # reading_session
    field :create_reading_session, mutation: Mutations::CreateReadingSession
    # field :delete_session, mutation: Mutation::DeleteReadingSession
    field :quit_session, mutation: Mutations::QuitSession
    field :submit_book, mutation: Mutations::SubmitBook

    # review
    field :create_review, mutation: Mutations::CreateReview
  end
end
