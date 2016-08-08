class NotificationMailer < ApplicationMailer
  default from: Settings.mailer.default_from

  def notice(email, subject, content)
    # TODO: Apply markdown to show rich content
    @content = content
    mail to: email, subject: subject
  end
end
