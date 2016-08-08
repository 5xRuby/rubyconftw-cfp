class NotificationMailer < ApplicationMailer
  default from: Settings.mailer.default_from

  def notice(email, notification)
    @content = notification.html_content
    mail to: email, subject: notification.subject
  end

end
