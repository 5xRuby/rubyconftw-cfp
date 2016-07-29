class PapersMailer < ApplicationMailer

  default from: Settings.mailer.default_from
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.papers_mailer.notification_after_create.subject
  #

  def notification_after_create(paper_id)
    @paper = Paper.find(paper_id)
    mail to: @paper.user.email, subject: "Your proposals is confirmed"
  end

end
