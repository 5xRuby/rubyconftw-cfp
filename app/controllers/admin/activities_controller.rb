class Admin::ActivitiesController < Admin::ApplicationController

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find_by(permalink: params[:id])
  end

  def new
    @activity = Activity.new
    @new_custom_field = CustomField.new
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      redirect_to admin_activities_path, notice: "成功新增活動"
    else
      render :new
    end

  end

  def edit
    @activity = Activity.find_by(permalink: params[:id])
    @new_custom_field = CustomField.new
  end

  def update
    @activity = Activity.find_by(permalink: params[:id])
    if @activity.update(activity_params)
      redirect_to admin_activities_path
    else
      render :edit
    end
  end

  def destroy
    @activity = Activity.find_by(permalink: params[:id])
    @activity.destroy
    redirect_to admin_activities_path
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :logo, :start_date, :end_date, :open_at, :close_at, :term, :permalink, :accept_attachement, custom_fields_attributes: [:id, :name, :required, :description, :field_type, :_destroy, :sort_order, :collection_text])

  end


end
