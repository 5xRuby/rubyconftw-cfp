class Admin::PapersController < Admin::ApplicationController
  before_action :set_activity
  before_action :set_paper, only: [:show, :update]
  def index
    @papers = @activity.papers
    @notification = Notification.new
  end

  def show
    @custom_fields = @activity.custom_fields
    @new_comment = Comment.new
  end

  def update
    @paper.update(paper_params)
    redirect_to admin_activity_paper_path(@activity, @paper)
  end
  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

  def paper_params
    params.require(:paper).permit(:tag_list)
  end
end
