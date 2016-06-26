class ActivitiesController < ApplicationController
	
	def index
		if params[:status] == "end"
		  @activities = Activity.where("end_date <?", Time.now)
		elsif params[:status] == "now"
		  @activities = Activity.where("end_date >=?", Time.now)
		else 
		  @activities = Activity.all
		end 
	end

	def show
		@activity = Activity.find(params[:id])	
	end

end
