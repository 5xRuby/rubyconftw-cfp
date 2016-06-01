class ActivitiesController < ApplicationController
	
	def index
		@activities = Activity.all
	end

	def new
		@activity = Activity.new
		@category = Category.new
	end

	def create
		@activity = Activity.new(activity_params)
		@category = Category.new

		if @activity.save 
			render :new
		else
			render :new
		end
		
	end

	def show
		@activity = Activity.find(params[:id])	

	end

	private

		def activity_params
			params.require(:activity).permit(:name, :description, :logo, :start_date, :end_date, :term)
		end

end
