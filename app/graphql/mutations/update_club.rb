# frozen_string_literal: true

module Mutations
  class UpdateClub < BaseMutation
    description 'Update a club'

    argument :club_id, ID, required: true, loads: Types::ClubType
    argument :label, String, required: false
    argument :description, String, required: false

    field :club, Types::ClubType, null: true

    def resolve(club:, **args)
      authorize! club, to: :update?, with: ClubPolicy

      club.update!(**args)

      { club: }
    end
  end
end
