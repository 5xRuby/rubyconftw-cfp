class Admin::PapersController < Admin::ApplicationController
  include ApplicationHelper
  before_action :set_activity
  before_action :set_paper, only: [:show, :update]

  add_sortable_column "users.name"

  def index
    @papers = apply_search_filter(Paper.joins(:user).where(activity: @activity).order("#{sort_column} #{sort_direction}"))
    @notification = Notification.new

    respond_to do |format|
      # TODO: Filter necessary columns
      format.yml {
        send_data @papers.as_yaml(include_root: true),
                  type: "application/yml",
                  disposition: "attachment; filename=papers.yml"
      }
      format.html
    end
  end

  def show
    @custom_fields = @activity.custom_fields
    @new_comment = Comment.new
  end

  def update
    @paper.update(paper_params)
    redirect_to admin_activity_paper_path(@activity, @paper)
  end
  private

  def set_activity
    @activity = Activity.find_by(permalink: params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

  def paper_params
    params.require(:paper).permit(:tag_list)
  end

  def apply_search_filter(query)
    if params[:commit] == "Search"
      if fixed_search_fields.include? params[:search_field]
        column = "lower(#{params[:search_field]})" # search_field should be safe
      elsif get_all_custom_field_strings.include? params[:search_field]
        # find the custom field by name
        custom_field = @activity.custom_fields.find_by!(name: params[:search_field])
        # combine sql
        column = "lower(answer_of_custom_fields->>'#{custom_field.id}')"
      else
        raise "Invalid search field"
      end
      # TODO default use % or not? 
      if params[:search_type] == "equal"
        query.where("#{column} = lower(?)", params[:search_key])
      else
        query.where("#{column} like lower(?)", "%#{params[:search_key]}%")
      end
    else
      params[:search_field] = ''
      params[:search_key] = ''
      query
    end
  rescue
    query
  end
end
