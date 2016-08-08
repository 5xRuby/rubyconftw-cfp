module Admin::PapersHelper
  def admin_reviewed_button(paper)
    return if paper.reviewed_by?(current_user)
    link_to "Reviewed", admin_paper_reviews_path(paper), method: "POST", class: "btn btn-success"
  end
end
