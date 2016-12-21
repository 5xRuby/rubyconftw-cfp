class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all.order(id: :asc)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :firstname, :lastname, :phone, :title, :company, :country, :twitter, :github_username)
  end
end
