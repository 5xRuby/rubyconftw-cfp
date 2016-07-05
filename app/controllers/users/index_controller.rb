class Users::IndexController < ApplicationController
  def show
  	@activities = Activity.includes(:papers).where(papers:{user_id: current_user.id})


  	# Activity.includes(:papers).where(papers: {user_id: 5})
  	# debugger
  	# @activities.each do |activity|
  	# 	activity.papers.where(user_id: current_user.id ).each do |paper|
  	# end
    # @submits = current_user.papers.where(activity_id: params[:activity_id])
                                                                                                                  
  end
end