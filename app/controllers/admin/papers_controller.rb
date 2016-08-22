class Admin::PapersController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_activity
  before_action :set_paper, only: [:show, :update]
  def index
    @papers = Paper.joins(:user).where(activity: @activity).order(sort_sql)
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

  def sort_sql
    "#{sort_column} #{sort_direction}"
  end


  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

  def sort_column
    return "users.name" if params[:sort] == "users.name"
    Paper.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    params[:direction] == "desc" ? "desc" : "asc"
  end

  def paper_params
    params.require(:paper).permit(:tag_list)
  end
end
