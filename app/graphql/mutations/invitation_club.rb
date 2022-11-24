# frozen_string_literal: true

module Mutations
  class InvitationClub < BaseMutation
    description 'Invitation user to a club'

    argument :club_id, ID, required: true, loads: Types::ClubType
    argument :email, String, required: true

    field :sent, Boolean, null: false

    def resolve(club:, email:)
      authorize! club, to: :invitation?, with: ClubPolicy

      UserMailer.invitation_club(email, club).deliver_later

      { sent: true }
    end
  end
end
