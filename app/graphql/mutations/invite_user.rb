# frozen_string_literal: true

module Mutations
  class InviteUser < BaseMutation
    description 'Invites a user to create an account'

    argument :email, String, required: true, description: 'Email of the invited user'

    field :sent, Boolean, null: true

    def resolve(**args)
      # authorize!(User, to: :invite?, context: { user: current_user })
      UserMailer.invite_user(**args).deliver_later

      { sent: true }
    end
  end
end
