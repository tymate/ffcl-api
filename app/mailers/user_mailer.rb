# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invitation_club(email:, club:)
    subject = 'Invitation à rejoindre un club'
    html = render partial: 'user_mailer/invitation_club', locals: {
      club:
    }
    send_mail(recipients: email, subject:, html:)
  end

  def invite_user(email:)
    subject = 'Invitation à créer un compte'
    html = render partial: 'user_mailer/invite_user'
    send_mail(recipients: email, subject:, html:)
  end
end
