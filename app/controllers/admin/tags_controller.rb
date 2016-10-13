class Admin::TagsController < ApplicationController
  def index
    render json: ActsAsTaggableOn::Tag.all
  end
end
