module Admin::ActivitiesHelper
  def admin_review_paper_link(activity)
    unreviewed_papers = activity.papers.size.to_i - activity.review_by(current_user).size.to_i
    link_to "Review Papers (#{unreviewed_papers})", admin_activity_papers_path(activity)
  end
end
