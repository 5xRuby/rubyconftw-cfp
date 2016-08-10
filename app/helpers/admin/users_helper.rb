module Admin::UsersHelper
  def toggle_admin_permission_button(user)
    if user.is_admin?
      link_to "undesignate to be admin ", admin_user_undesignate_path(user), class: "btn btn-danger"
    else
      link_to "designate to be admin ", admin_user_designate_path(user), class: "btn btn-danger"
    end
  end

  def toggle_contributor_role_button(user)
    if user.is_contributor?
      link_to "Unmark as contributor", admin_user_contributor_path(user), method: "DELETE", class: "btn btn-primary"
    else
      link_to "Mark as contributor", admin_user_contributor_path(user), method: "POST", class: "btn btn-primary"
    end
  end
end
