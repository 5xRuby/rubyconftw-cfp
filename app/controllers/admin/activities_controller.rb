class Admin::ActivitiesController < ApplicationController
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
    if @activity.create
      redirect_to  admin_activities_path
    else
      render :new
    end
    
  end
  
  def edit
  end
  
  def update
    if @activity.update
      redirect_to admin_activities_path
    else
      render :edit
    end
  end
  
  def destroy
    @activity.destroy
  end

  private
  
  def activity_params
    params.require(:activity).permit(:name, :description, :logo, :start_date, :end_date, :term) 
  end
  

end
