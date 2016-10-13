class Admin::StatsController < ApplicationController
  before_action -> { @activity = Activity.find_by(permalink: params[:activity_id]) }

  def show
    @total_papers = @activity.papers.size
    @custom_fields = @activity.custom_fields
    @custom_field_answers = @activity.custom_field_answers
  end
end
