class Admin::PapersController < ApplicationController
  before_action :set_activity
  before_action :set_paper, only: [:show]
  def index
    @papers = @activity.papers
    @notification = Notification.new
  end

  def show
  end

  def create
    @notification = Notification.new(mail_params)
    redirect_to admin_activity_papers_path(@activity) if @notification.valid?
    @papers = @activity.papers
    render "index"
  end

  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find(params[:id])
  end

  def mail_params
    params.require(:notification).permit(:content, :subject, :ids => [])
  end

  def receivers(ids)
    User.find(ids.uniq).pluck(:email)
  end

  def send_mails(notification)
    receivers(mail_params[:ids]).each do |email|
      NotificationMailer.notice(email, notification).deliver_now
    end
  end

end
