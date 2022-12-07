# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user
module Previews
  class UserPreview < ActionMailer::Preview
    def invitation_club
      UserMailer.invitation_club(User.first.email, Club.first)
    end
  end
end
