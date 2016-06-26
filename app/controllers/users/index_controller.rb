class Users::IndexController < ApplicationController
  def show
    # @submits = current_user.papers
    @submits = current_user.papers

  end
end