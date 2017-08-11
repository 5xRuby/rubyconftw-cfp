module Admin::ActivitiesHelper
  def admin_review_paper_link(activity)
    if activity
      # (All Papers) - (Current User Reviewed) - (Unreviewed but Withdrawn/Accept/Reject)
      unreviewed_papers = activity.unreview_by(current_user).size.to_i
      content_tag :li, link_to("Review Papers (#{unreviewed_papers})", admin_activity_papers_path(activity))
    else
      content_tag :li, link_to("Review Papers (0)", nil), class: "disabled"
    end
  end

  def notifier_service_info_value(form_builder, key)  
    notifier = form_builder.object
    notifier.service_info[key]
  end

  def notifier_service_info_field_data(form_builder, field_key)
    data = {
      required: Notifier::REQUIRED_SERVICE_INFO.include?(field_key),
      hint: Notifier::SERVICE_INFO_HINT[field_key],
    }
    attach_common_info!(form_builder, field_key, data)
  end

  def attach_common_info!(form_builder, field_key, data)
    data.merge!({
      value: notifier_service_info_value(form_builder, field_key),
      error_message: form_builder.object.service_info_errors[field_key],
    })
  end
end
