class ActivitiesController < ApplicationController
  before_action :find_activity, only: [:show]
	def index
	  @activities = Activity.all
	end

	def show

	end

  protected

  def find_activity
    @activity = Activity.find_by(permalink: params[:id])
    if @activity.nil? && activity = Activity.find(params[:id])
      redirect_to activity_path(activity)
      return false
    end
  end
end
