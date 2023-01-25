# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_FROM', nil)
  layout 'mailer'

  def send_mail(recipients:, subject:, html:)
    ms_email = Mailersend::Email.new
    ms_email.add_recipients('email' => recipients)
    ms_email.add_from('email' => ENV.fetch('MAIL_FROM', nil))
    ms_email.add_subject(subject)
    ms_email.add_html(html)
    ms_email.send
  end
end
