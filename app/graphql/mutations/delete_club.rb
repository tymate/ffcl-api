# frozen_string_literal: true

module Mutations
  class DeleteClub < BaseMutation
    description 'Delete a club'

    argument :club_id, ID, required: true, loads: Types::ClubType

    field :deleted, Boolean, null: false

    def resolve(club:)
      authorize! club, to: :destroy?
      club.destroy!

      { deleted: true }
    end
  end
end 
