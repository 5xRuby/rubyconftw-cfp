class ActivitiesController < ApplicationController
	
	def index
		@activities = Activity.where("end_date < ?", Time.now)
	end

	def show
		@activity = Activity.find(params[:id])	
	end

end
