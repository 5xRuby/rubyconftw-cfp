class ApplicationMailer < ActionMailer::Base
  default reply_to: Settings.mailer.default_reply_to, from: Settings.mailer.default_from, bcc: Settings.mailer.try(:bcc_email) || []
  layout 'mailer'
end
