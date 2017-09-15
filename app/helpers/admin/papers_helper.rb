module Admin::PapersHelper
  def admin_review_button(paper)
    return if !paper.may_view?
    link_to "Review", admin_paper_reviews_path(paper), method: "POST", class: "btn btn-success"
  end

  def admin_approve_button(paper)
    return if !paper.may_view?
    link_to "Approve", admin_paper_approve_path(paper), method: "POST", class: "btn btn-success"
  end

  def admin_disapprove_button(paper)
    return if !paper.may_view?
    link_to "Dispprove", admin_paper_disapprove_path(paper), method: "POST", class: "btn btn-danger"
  end

  def admin_accept_button(paper)
    return if !paper.may_accept?
      link_to "Accept", admin_paper_accept_path(paper), method: "POST", class: "btn btn-success"
  end

  def admin_reject_button(paper)
    return if !paper.may_reject?
      link_to "Reject", admin_paper_reject_path(paper), method: "POST", class: "btn btn-danger"
  end
end
