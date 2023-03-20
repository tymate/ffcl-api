# frozen_string_literal: true

module Mutations
  class QuitClub < BaseMutation
    description 'Quit a club'

    argument :club_id, ID, required: true, loads: Types::ClubType

    field :club, Types::ClubType, null: true

    def resolve(club:)
      authorize! User, to: :quit_club?

      club.users.delete(current_user) if club.users.include?(current_user) && current_user != club.admin

      { club: }
    end
  end
end
