class Admin::StatsController < Admin::ApplicationController
  before_action -> { @activity = Activity.find_by(permalink: params[:activity_id]) }

  def show
    @total_papers = papers.size
    @custom_fields = @activity.custom_fields
    @custom_field_answers = custom_field_answers
    @tags = tags.order(taggings_count: :desc, name: :asc)
  end

  def papers
    return @activity.papers.where(user_id: speakers) if speaker_only?
    @activity.papers
  end

  def custom_field_answers
    return @activity.custom_field_answers.where(user_id: speakers) if speaker_only?
    @activity.custom_field_answers
  end

  def tags
    return @activity.accepted_paper_tags if speaker_only?
    @activity.tags
  end

  def speakers
    @activity.speakers
  end

  def speaker_only?
    params[:speaker_only]
  end
end
