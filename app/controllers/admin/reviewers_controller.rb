class Admin::ReviewersController < ApplicationController
  before_action :set_activity, :set_relationships
  authorize_resource :user_activity_relationship

  def index
    @reviewers = []
    @relationships.each do |relationship|
      @reviewers << User.find(relationship.user_id)
    end
  end

  def new
    @relationship = UserActivityRelationship.new
    @users = User.all
  end

  def create
    @relationship = UserActivityRelationship.new(relationship_params)
    @relationship.activity_id = @activity.id
    if @relationship.save
      flash[:notice] = "Add new reviewer successfully!"
      redirect_to admin_activity_reviewers_path
    else
      render :new
    end
  end

  def destroy
    @relationship = UserActivityRelationship.where(activity_id: params[:activity_id], user_id: params[:id])
    @relationship.each do |relationship|
      relationship.destroy
    end
    redirect_to admin_activity_reviewers_path
  end
  private

  def set_activity
    @activity = Activity.find_by(permalink: params[:activity_id])
  end
  def set_relationships
    @relationships = UserActivityRelationship.where(activity_id: @activity.id)
  end
  def relationship_params
    params.require(:user_activity_relationship).permit(:user_id)
  end
end
