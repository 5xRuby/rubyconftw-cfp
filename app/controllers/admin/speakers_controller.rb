class Admin::SpeakersController < Admin::ApplicationController
  before_action :set_activity

  def index
    @speakers = @activity.speakers

    respond_to do |format|
      format.yml {
        send_data @speakers.as_yaml(include_root: true),
        type: "application/yaml",
        disposition: "attachment; filename=speakers.yml"
      }
      format.html { render }
    end
  end

  def set_activity
    @activity = Activity.find_by(permalink: params[:activity_id])
  end
end

