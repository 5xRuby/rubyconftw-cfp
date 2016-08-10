class ContributorsController < ApplicationController
  def show
    @contributors = User.where(is_contributor: true)
  end
end
