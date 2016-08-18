class ActivitiesController < ApplicationController
	def index
		  @activities = Activity.all
	end

	def show
    if params[:id] =~ /\A\d+\z/
      @activity = Activity.find(params[:id])
      redirect_to activity_path(@activity)
    else
		  @activity = Activity.find_by(permalink: params[:id])
    end
	end
end
