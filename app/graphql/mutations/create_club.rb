# frozen_string_literal: true

module Mutations
  class CreateClub < BaseMutation
    description 'Create a new club'

    argument :label, String, required: true
    argument :description, String, required: false

    field :club, Types::ClubType, null: true
    field :user, Types::UserType, null: true

    def resolve(**args)
      authorize! Club, to: :create?
      club = Club.create!(
        **args,
        admin: current_user,
        invitation_code: rand(100_000..999_999),
        users: [current_user]
      )

      club.users << current_user

      { club: }
    end
  end
end
