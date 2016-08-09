module Admin::PapersHelper
  def admin_review_button(paper)
    return if paper.reviewed_by?(current_user)
    link_to "Review", admin_paper_reviews_path(paper), method: "POST", class: "btn btn-success"
  end

  def admin_accept_button(paper)
    return if !paper.reviewed?
      link_to "Accept", admin_paper_accept_path(paper), method: "POST", class: "btn btn-success"
  end

  def admin_reject_button(paper)
    return if !paper.reviewed?
      link_to "Reject", admin_paper_reject_path(paper), method: "POST", class: "btn btn-danger"
  end
end
