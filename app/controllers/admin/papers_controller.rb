class Admin::PapersController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_activity
  before_action :set_paper, only: [:show]
  def index
    @papers = Paper.where(activity: @activity).order(sort_column + " "+ sort_direction)
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
    Paper.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    params[:direction] == "desc" ? "desc" : "asc"
  end

end
