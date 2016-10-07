class Admin::PapersController < Admin::ApplicationController
  before_action :set_activity
  before_action :set_paper, only: [:show, :update]

  add_sortable_column "users.name"

  def index
    @papers = Paper.joins(:user).where(activity: @activity).order("#{sort_column} #{sort_direction}")
    @notification = Notification.new

    respond_to do |format|
      # TODO: Filter necessary columns
      format.yml {
        send_data @papers.as_yaml(include_root: true),
                  type: "application/yml",
                  disposition: "attachment; filename=papers.yml"
      }
      format.html
    end
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
    @activity = Activity.find_by(permalink: params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

  def paper_params
    params.require(:paper).permit(:tag_list)
  end
end
