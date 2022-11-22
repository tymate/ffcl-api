# frozen_string_literal: true

module Mutations
  class UpdateClub < BaseMutation
    description 'Update a club'

    argument :id, ID, required: true
    argument :label, String, required: false
    argument :description, String, required: false

    field :club, Types::ClubType, null: true

    def resolve(id:, **args)
      club = Club.find(id)
      authorize! club, to: :update?, with: ClubPolicy

      club.update!(**args)

      { club: }
    end
  end
end
