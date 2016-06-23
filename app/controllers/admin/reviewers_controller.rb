class Admin::ReviewersController < ApplicationController
  before_action :set_activity, :set_relationships
  def index
    @reviewers = []
    @relationships.each do |relationship|
      @reviewers << User.find(relationship.user_id)
    end
  end
  
  def new
    @relationship = UserActivityRelationship.new 
  end
  def update
    relationship_params[:activity_id] = @activity.id
    @relationship = UserActivityRelationship.new(relationship_params)
    if @relationship.save
      flash[:notice] = "Add new reviewer successfully!"
    else
      render :new
    end
  end
  private
  
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end
  def set_relationships
    @relationships = UserActivityRelationship.where(activity_id: @activity.id)
  end
  def relationship_params
    params.require(:user_activity_relationship).permit(:user_id)
  end
end
