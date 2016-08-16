class Admin::TagsController < ApplicationController
  before_action :set_activity
  before_action :set_tag, only: :destroy
  def create
    @paper = Paper.find_by(uuid: params[:paper_id])
    @tag = @paper.tags.new(tag_params)
    if @tag.save
      redirect_to admin_activity_papers_path(@activity), notice: "tag is created successfully"
    else
      redirect_to admin_activity_papers_path(@activity), alert: "Error occurs!"
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_activity_papers_path(@activity), notice: "tag is deleted successfully"
  end

  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end
  def set_tag
    @tag = Tag.find(params[:id])
  end
  def tag_params
    params.require(:tag).permit(:name, :color, :paper_id)
  end

end
