module PapersHelper
  def build_custom_field_input(form_builder, custom_field, base_attr = :answer_of_custom_fields)
    base_obj = form_builder.object
    prefix = form_builder.object_name
    value_field_name = "#{prefix}[#{base_attr}][#{custom_field.id}]"
    value = base_obj.send(base_attr).send(:"[]", custom_field.id.to_s)
    case custom_field.field_type
    when 'text'
      text_area_tag value_field_name, value, class: "form-control"
    when 'checkboxes'
      render partial: "checkboxes", locals: {custom_field: custom_field, value_field_name: value_field_name, value: value}
    when 'radios'
      render partial: "radios", locals: {custom_field: custom_field, value_field_name: value_field_name, value: value}
    when 'selects'
      render partial: "selects", locals: {custom_field: custom_field, value_field_name: value_field_name, value: value}  
    else #text
      text_field_tag value_field_name, value, class: "form-control"
    end

  end

  def paper_state_badge(paper)
    style = "label label-info"
    case paper.state
    when "accepted"
      style = "label label-success"
    when "rejected"
      style = "label label-danger"
    when "withdrawn"
      style = "label label-warning"
    end
    content_tag :span, paper.state, class: style
  end

  def withdraw_proposal_button(activity, paper, custom_options = {})
    return if paper.withdrawn?

    options = {method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-warning"}
    options.merge!(custom_options)

    link_to activity_paper_path(activity, paper), options  do
      concat content_tag(:span, nil, class: "fa fa-exclamation-circle")
      concat " Withdraw Proposal"
    end
  end
end
