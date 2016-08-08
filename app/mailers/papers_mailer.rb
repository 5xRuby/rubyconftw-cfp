class PapersMailer < ApplicationMailer
  default from: Settings.mailer.default_from

  def notification_after_create(paper_id)
    @paper = Paper.find(paper_id)
    mail to: @paper.user.email, subject: "Your proposals is confirmed"
  end
  
end
