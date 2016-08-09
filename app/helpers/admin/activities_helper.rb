module Admin::ActivitiesHelper
  def admin_review_paper_link(activity)
    return 0 if activity.nil?
    label = "Review Papers"
    unreviewed_papers = activity.papers.size - activity.review_by(current_user).size
    label << "(#{unreviewed_papers})"

    link_to label, admin_activity_papers_path(activity)
  end
end
