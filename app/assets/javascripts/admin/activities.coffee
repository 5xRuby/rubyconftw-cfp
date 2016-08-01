jQuery ->
  $("#add-field").on "click", (event) ->
    event.preventDefault()
    form = $("#add-field").attr("data-form-content")
    new_num = $('.custom-field').length
    new_form = form.replace(/\[\d+?\]/g, "[#{new_num}]" ).replace(/\_\d+?\_/g, "_#{new_num}_")
    $("#input_fields_container").append new_form
  $('#input_fields_container').on 'click', '.remove-new', ->
    $(@).parents('.custom-field').remove()
  $('#input_fields_container').on 'click', '.remove-exist', ->
    $(@).parents('.custom-field').hide()
  $('.edit_activity, .new_activity').on 'submit', ->
    $('#input_fields_container').find('.sort-order').each (idx) ->
      $(@).val(idx + 1)

