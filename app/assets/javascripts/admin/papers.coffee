jQuery ->
  $('.edit-tag-button').on 'click', ->
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').removeClass("hide")

  $('.remove-tag-field').on 'click', (e) ->
    e.preventDefault
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').addClass("hide")
  $('.papers').on 'click', '.paper-tag', (e) ->
    tag_name = $(@).data("tag-name")
    $(".paper-tag[data-tag-name='#{tag_name}']").parents("tr").find("input[type=checkbox]").trigger('click')

  # Toggle paper's checkbox
  $paper_checkboxes = $("input[name='notification[ids][]']")
  $check_all_checkbox = $('#notification_check_all')

  $check_all_checkbox.on 'click', (e) ->
    check_status = $check_all_checkbox.prop('checked')
    $paper_checkboxes.prop('checked', check_status) # Toggle it





