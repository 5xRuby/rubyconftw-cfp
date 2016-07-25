class PapersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.papers_mailer.sent_cfp_email.subject
  #
  def sent_cfp_email
    @greeting = "Hi"

    mail to: "cfptestgogo@gmail.com"
  end

  def send_inviting_email(paper)
    @paper = paper
    @user = paper.users.first
    @activity = paper.activity

    mail to: paper.inviting_email, subject: "[#{@activity.name}] #{@user.firstname} #{@user.lastname} invited you to be co-presenter on cfp"
  end
end
