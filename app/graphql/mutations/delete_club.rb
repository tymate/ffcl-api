# frozen_string_literal: true

module Mutations
  class DeleteClub < BaseMutation
    description 'Delete a club'

    argument :id, ID, required: true

    field :club, Types::ClubType, null: true

    def resolve(id:)
      club = Club.find(id)
      authorize! club, to: :destroy?, with: ClubPolicy

      club.destroy!

      { club: }
    end
  end
end
