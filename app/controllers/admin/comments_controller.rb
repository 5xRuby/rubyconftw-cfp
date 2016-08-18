class Admin::CommentsController < Admin::ApplicationController
  before_action :set_activity, :set_paper
  before_action :set_comment, only: :destroy
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.paper = @paper
    if @comment.save
      redirect_to admin_activity_paper_path(@activity, @paper), notice: "comment is created successfully"
    else
      redirect_to admin_activity_paper_path(@activity, @paper), alert: "Error occurs!"
    end
  end

  def destroy
    @comment.destroy
    redirect_to admin_activity_paper_path(@activity, @paper), notice: "comment is deleted successfully"
  end

  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end
  def set_paper
    @paper = Paper.find_by(uuid: params[:paper_id])
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:text)
  end
end
