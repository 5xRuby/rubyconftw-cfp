module Admin::UsersHelper
  def toggle_admin_permission_button(user)
    if user.is_admin?
      link_to "undesignate to be admin ", admin_user_undesignate_path(user), class: "btn btn-danger"
    else
      link_to "designate to be admin ", admin_user_designate_path(user), class: "btn btn-danger"
    end
  end
end
