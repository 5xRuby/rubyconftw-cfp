module Admin::ActivitiesHelper
  def admin_review_paper_link(activity)
    if activity
      unreviewed_papers = activity.papers.size.to_i - activity.review_by(current_user).size.to_i
      content_tag :li, link_to("Review Papers (#{unreviewed_papers})", admin_activity_papers_path(activity))
    else
      content_tag :li, link_to("Review Papers (0)", nil), class: "disabled"
    end
  end
end
