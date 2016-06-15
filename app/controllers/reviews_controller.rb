class ReviewsController < ApplicationController
  def index
    @papers = Paper.all
  end
  def review
    @paper = Paper.find(params[:id])
  end
  def reviewed
    @paper = Paper.find(params[:id])
  end

end
