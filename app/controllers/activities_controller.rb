class ActivitiesController < ApplicationController
  before_action :find_activity, only: [:show]
	def index
	  @activities = Activity.all
	end

	def show

	end

  protected

  def find_activity
    @activity = begin
                  Activity.find_by(permalink: params[:id])
                rescue ActiveRecord::RecordNotFound
                  Activity.find(params[:id])
                end
  end
end
