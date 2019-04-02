class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_permissions, :only => [:new, :create, :cancel]
  skip_before_action :require_no_authentication

  protected

  def check_permissions
    authorize! :create, resource
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def update_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end

