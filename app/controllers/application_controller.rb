class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  def new_session_path(scope)
    new_user_session_path
  end
   
  protected 
   
  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :firstname
      devise_parameter_sanitizer.for(:account_update) << :lastname
      devise_parameter_sanitizer.for(:account_update) << :phone
      devise_parameter_sanitizer.for(:account_update) << :title
      devise_parameter_sanitizer.for(:account_update) << :company
      devise_parameter_sanitizer.for(:account_update) << :country
      devise_parameter_sanitizer.for(:account_update) << :photo
  end
end
