class Users::IndexController < ApplicationController
  def show
  	@activities = Activity.all
  	# @activities.each do |activity|
  	# 	activity.papers.where(user_id: current_user.id ).each do |paper|
  	# end
    # @submits = current_user.papers.where(activity_id: params[:activity_id])
                                                                                                                  
  end
end