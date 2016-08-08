class Admin::MailsController < ApplicationController
  before_action -> { @activity = Activity.find(params[:activity_id]) }

  def create
    subject = mail_params[:subject]
    content = mail_params[:content]
    receivers(mail_params[:ids]).each do |email|
      NotificationMailer.notice(email, subject, content).deliver_now
    end
    redirect_to admin_activity_papers_path(@activity)
  end

  protected
  def mail_params
    params.require(:mail).permit(:content, :subject, :ids => [])
  end

  def receivers(ids)
    User.find(ids.uniq).pluck(:email)
  end
end
