# Preview all emails at http://localhost:3000/rails/mailers/papers_mailer
class PapersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/papers_mailer/sent_cfp_email
  def sent_cfp_email
    PapersMailer.sent_cfp_email
  end

end
