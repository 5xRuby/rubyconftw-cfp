class NotificationMailer < ApplicationMailer
  default from: Settings.mailer.default_from

  def notice(email, subject, content)
    # TODO: Apply markdown to show rich content
    @content = markdown(content)
    mail to: email, subject: subject
  end

  protected
  def markdown(content)
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true)

    markdown.render(content)
  end
end
