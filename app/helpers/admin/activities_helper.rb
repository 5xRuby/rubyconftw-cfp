module Admin::ActivitiesHelper
  def admin_review_paper_link(activity)
    label = link_to "Review Papers", nil
    return label if activity.nil?
    unreviewed_papers = activity.papers.size - activity.review_by(current_user).size
    label << "(#{unreviewed_papers})"

    link_to label, admin_activity_papers_path(activity)
  end
end
