class ApplicationMailer < ActionMailer::Base
  default reply_to: Settings.mailer.default_reply_to, from: Settings.mailer.default_from, bcc: Settings.mailer&.bcc_emails.to_s.split(',')
  layout 'mailer'

end
