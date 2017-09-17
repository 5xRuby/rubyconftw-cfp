module Admin::PapersHelper
  def admin_approve_button(paper, user)
    review = Review.find_by(paper: paper, user: user)
    return if review
    link_to "approve", admin_paper_approve_path(paper), method: "POST", class: "btn btn-success"
  end

  def admin_disapprove_button(paper, user)
    review = Review.find_by(paper: paper, user: user)
    return if review
    link_to "disapprove", admin_paper_disapprove_path(paper), method: "POST", class: "btn btn-danger"
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
