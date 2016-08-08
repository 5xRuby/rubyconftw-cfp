class Admin::ReviewsController < ApplicationController
  before_action :current_paper, if: -> { params.has_key?(:paper_id) }

  def create
    @paper.reviews.create!(user: current_user, reviewed: true)
    redirect_to admin_activity_papers_path(@paper.activity_id, @paper)
  rescue
    redirect_to admin_activity_papers_path(@paper.activity_id, @paper), alert: "You already reviewd this paper"
  end

  protect_from_forgery

  protected
  def current_paper
    @paper = Paper.find(params[:paper_id])
  end
end
