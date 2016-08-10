class Admin::ContributorsController < Admin::ApplicationController
  before_action -> { @user = User.find(params[:user_id]) }, expect: [:index, :new, :edit]

  def create
    @user.update_attributes!(is_contributor: true)
    redirect_to admin_users_path
  end

  def destroy
    @user.update_attributes!(is_contributor: false)
    redirect_to admin_users_path
  end
end
