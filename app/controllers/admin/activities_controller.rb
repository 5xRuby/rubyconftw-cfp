class Admin::ActivitiesController < Admin::ApplicationController
  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
    @category = Category.new
  end

  def create
    @activity = Activity.new(activity_params)
    @category = Category.new
    if @activity.save
      render :new
    else
      render :new
    end

  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      redirect_to admin_activities_path
    else
      render :edit
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to admin_activities_path
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :logo, :start_date, :end_date, :event_start_date, :event_end_date, :term, custom_fields_attributes: [:name, :activity_id, :field_type, :required, :options])
  end


end
