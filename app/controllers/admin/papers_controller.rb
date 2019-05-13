class Admin::PapersController < Admin::ApplicationController
  include ApplicationHelper
  before_action :set_activity
  before_action :set_paper, only: [:show, :update]

  add_sortable_column "users.name"

  def index
    @papers = apply_search_filter(Paper.preload(:user, :activity, :comments, :reviews).joins(:user).where(activity: @activity).order("#{sort_column} #{sort_direction}"))
    @notification = Notification.new

    respond_to do |format|
      # TODO: Filter necessary columns
      format.yml do
        send_data @papers.as_yaml(include_root: true, hostname: request.host_with_port),
                  type: "application/yml",
                  disposition: "attachment; filename=papers.yml"
      end
      format.xlsx do
        send_file PapersXLSXExporter.new(@papers).perform
      end
      format.html
    end
  end

  def show
    @custom_fields = @activity.custom_fields
    @new_comment = Comment.new
  end

  def update
    @paper.update(paper_params)
    respond_to do |format|
      format.html { redirect_to admin_activity_paper_path(@activity, @paper) }
      format.json {
        html = render_to_string(partial: "display_tags", formats: [:html], locals: {tags: @paper.tags})
        render json: {paper: @paper, tags: @paper.tags.collect{|t| t.name}, display_tags_html: html}
      }
    end
  end
  private

  def set_activity
    @activity = Activity.preload(:custom_fields).find_by(permalink: params[:activity_id])
  end

  def set_paper
    @paper = @activity.papers.find_by(uuid: params[:id])
  end

  def paper_params
    params.require(:paper).permit(:tag_list)
  end

  def apply_search_filter(query)
    if params[:commit] == "Search"
      # search by tag
      if params[:search_field] == "tag"
        wild = params[:search_type] != "equal"
        final_q = query
        params[:search_key].split(",").each do |tag|
          final_q = final_q.tagged_with(tag, any: true, wild: wild)
        end
        final_q
      else # search by column
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
        if params[:search_type] == "equal"
          query.where("#{column} = lower(?)", params[:search_key])
        else
          query.where("#{column} like lower(?)", "%#{params[:search_key]}%")
        end
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
