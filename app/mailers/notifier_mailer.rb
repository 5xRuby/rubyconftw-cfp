class NotifierMailer < ApplicationMailer
  default from: Settings.mailer.default_from

  def send_message(email, subject, message)
    @content = message
    mail to: email, subject: subject
  end
end
