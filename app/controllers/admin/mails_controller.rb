class Admin::MailsController < ApplicationController

  before_action -> { @activity = Activity.find(params[:activity_id]) }

  def create
    @notification = Notification.new(mail_params.permit(:subject, :content))
    if @notification.valid?
      send_mails(@notification)
      return redirect_to admin_activity_papers_path(@activity), notice: "Mail already sent"
    end
    @papers = @activity.papers
    render "admin/papers/index"
  end


  private
  def mail_params
    params.require(:notification).permit(:content, :subject, :ids => [])
  end

  def receivers(ids)
    User.find(ids || []).pluck(:email)
  end

  def send_mails(notification)
    receivers(mail_params[:ids]).each do |email|
      NotificationMailer.notice(email, notification, {activity: @activity}).deliver_later
    end
  end
end
