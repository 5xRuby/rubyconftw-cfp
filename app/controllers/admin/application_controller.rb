class Admin::ApplicationController < ApplicationController
  before_action :check_permission
  
  private
  
  def check_permission
    unless user_signed_in? && current_user.is_admin
    redirect_to root_path
    flash[:warning] = "Permission Denied"
    end
  end
end
