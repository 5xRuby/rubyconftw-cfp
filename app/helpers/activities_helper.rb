module ActivitiesHelper
  TimeFormat = "%Y-%m-%d %H:%M %z"

  def show_activity_open_state(act)
    I18n.t "activity.status.#{act.status}"
  end

  def show_activity_open_and_close_date(act)
    case act.status
    when :opened
      "Will close at #{act.close_at.strftime(TimeFormat)}"
    when :not_yet_opened
      "Will open from #{act.open_at.strftime(TimeFormat)} to #{act.close_at.strftime(TimeFormat)}"
    else
      "Closed on #{act.close_at.to_date}"
    end
  end

end
