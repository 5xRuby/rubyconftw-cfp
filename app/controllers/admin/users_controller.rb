class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def designate
    @user = User.find(params[:user_id])
    @user.update(is_admin: true)
    @user.save
    redirect_to admin_users_path
  end

  def undesignate
    @user = User.find(params[:user_id])
    @user.update(is_admin: false)
    @user.save
    redirect_to admin_users_path
  end
end
