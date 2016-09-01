class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :sort_column, :sort_direction

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def resources
    controller_name.classify.constantize
  end

  def sort_column
    sortable_column.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    params[:direction] == "desc" ? "desc" : "asc"
  end

  def sortable_column
    @sortable_column ||= []
    return ["id"] + @sortable_column unless resources.respond_to?(:column_names)
    resources.column_names +  @sortable_column
  end

  def self.add_sortable_column(*args)
    before_action do
      @sortable_column ||= []
      @sortable_column.push(*args)
    end
  end

  protect_from_forgery with: :exception
  def new_session_path(scope)
    new_user_session_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :firstname, :lastname, :phone, :title, :company, :country, :photo, :twitter])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || activities_path || root_path
  end
end
