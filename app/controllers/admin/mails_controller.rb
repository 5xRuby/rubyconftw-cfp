class Admin::MailsController < ApplicationController

  before_action -> { @activity = Activity.find_by(permalink: params[:activity_id]) }

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
    params.require(:notification).permit(:content, :subject, ids: [])
  end

  def papers(ids)
    Paper.preload(:user).find(ids || [])
  end

  def send_mails(notification)
    papers(mail_params[:ids]).each do |paper|
      user = paper.user
      NotificationMailer.notice(user.email, notification, {user: user, paper:paper, activity: @activity}).deliver_now
    end
  end
end
