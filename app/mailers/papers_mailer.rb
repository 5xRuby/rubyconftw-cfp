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
end
