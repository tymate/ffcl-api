# frozen_string_literal: true

module Mutations
  class Register < BaseMutation
    description 'Register a new user'

    argument :email, String, required: true
    argument :password, String, required: true
    argument :username, String, required: true

    field :user, Types::UserType, null: true

    def resolve(**args)
      user = User.new(args)
      user.save!

      { user: }
    end
  end
end
