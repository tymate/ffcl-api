# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invitation_club(email, club)
    @email = email
    @club = club
    mail(to: @email, subject: 'Invitation to a club') # rubocop:disable Rails/I18nLocaleTexts
  end
end
