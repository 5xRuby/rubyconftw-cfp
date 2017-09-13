module ApplicationHelper
  SELECTED_PARAMS = %i(search_field search_type search_key commit)

  def markdown(content)
    @markdown_renderer ||= ::RougeHTML.new(filter_html: true)
    @markdown ||= Redcarpet::Markdown.new(@markdown_renderer, autolink: true, fenced_code_blocks: true)
    @markdown.render(content|| "")
  end

  def flash_message
    alert_types = { notice: :success, alert: :danger }

    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag :button, "×", close_button_options

    alerts = flash.map do |type, message|
      alert_content = close_button + sanitize(message)

      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"

      content_tag :div, alert_content, class: alert_class
    end

    alerts.join("\n").html_safe
  end

  def page_title(title)
    title || t('meta.title')
  end

  def page_description(desc)
    desc || t('meta.description')
  end

  def page_image(image = nil)
    image || t('meta.image')
  end

  def sortable(column)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "sort-amount-#{direction} current" : "sort"
    link_to "", merge_with_params({sort: column, direction: direction}), class: "sort fa fa-" + css_class
  end

  def merge_with_params(new_params)
    params.permit(SELECTED_PARAMS).merge(new_params)
  end

  def get_all_custom_field_strings
    @activity.custom_fields.collect{|f| f.name}
  end

  def fixed_search_fields
    %w(state country speaker_bio tag)
  end
end
