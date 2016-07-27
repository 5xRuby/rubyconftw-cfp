module ActivitiesHelper
  def status(activity)
    activity.end_date > Time.now ? "open" : "closed"
  end
end
