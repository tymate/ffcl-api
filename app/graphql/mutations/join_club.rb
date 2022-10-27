# frozen_string_literal: true

module Mutations
  class JoinClub < BaseMutation
    description 'Join a club'

    argument :invitation_code, Integer, required: true

    field :club, Types::ClubType, null: true

    def resolve(invitation_code:)
      club = Club.find_by(invitation_code:)
      club.users << current_user

      { club: }
    end
  end
end
