class CategoriesController < ApplicationController
	def create
		activity = Activity.find(params[:activity_id]) 
		@category = Category.create(category_params)
		activity.categories << @category

		respond_to do |format|
			format.js
		end
	end

	private 
		def category_params
			params.require(:category).permit(:name)
		end
end
