# frozen_string_literal: true

Clearance.configure do |config|
  config.mailer_sender = ENV.fetch('MAIL_FROM', nil)
  config.rotate_csrf_on_sign_in = true
end
