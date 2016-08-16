class Admin::PapersController < Admin::ApplicationController
  before_action :set_activity
  before_action :set_paper, only: [:show]
  def index
    @papers = @activity.papers
    @notification = Notification.new
    @new_tag = Tag.new
  end

  def show
    @custom_fields = @activity.custom_fields
    @new_comment = Comment.new
  end

  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

end
