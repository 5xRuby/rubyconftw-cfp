class ActivitiesController < ApplicationController
	
	def index
		if params[:status] == "end"
		  @activities = Activity.where("end_date <?", Time.now)
		else
		  @activities = Activity.where("end_date >=?", Time.now)
		end 
	end

	def show
		@activity = Activity.find(params[:id])	
	end

end
