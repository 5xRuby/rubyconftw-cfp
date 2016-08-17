class Admin::PapersController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_activity
  before_action :set_paper, only: [:show]
  def index
    if params[:sort] = "user"
      @papers = Paper.joins(:user).where(activity: @activity).order("users.name "+ sort_direction)
    else
      @papers = Paper.where(activity: @activity).order(sort_column + " "+ sort_direction)
    end
    @notification = Notification.new
  end

  def show
    @custom_fields = @activity.custom_fields
  end

  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

  def sort_column
    return "user" if params[:sort] == "user"
    Paper.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    params[:direction] == "desc" ? "desc" : "asc"
  end

end
