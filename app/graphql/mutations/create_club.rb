# frozen_string_literal: true

module Mutations
  class CreateClub < BaseMutation
    description 'Create a new club'

    argument :label, String, required: true
    argument :description, String, required: false

    field :club, Types::ClubType, null: true

    def resolve(**args)
      authorize! Club, to: :create?
      club = Club.create!(
        **args,
        club_admin: current_user,
        invitation_code: rand(100_000..999_999)
      )

      { club: }
    end
  end
end
