class NotificationMailer < ApplicationMailer

  def notice(email, notification, locals = {})
    @content = notification.html_content do |content|
      render_to_string(inline: content, locals: locals)
    end
    mail to: email, subject: notification.subject
  end

end
