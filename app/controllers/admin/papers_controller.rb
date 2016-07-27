class Admin::PapersController < ApplicationController
  before_action :set_activity
  before_action :set_paper, only: [:show]
  def index
    @papers = @activity.papers
  end
  def show
  end

  private
  def set_activity
    @activity = Activity.find(params[:activity_id])
  end
  def set_paper
    @paper = @activity.papers.find(params[:id])
  end
end
