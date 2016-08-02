jQuery ->
  $("#add-field").on "click", (event) ->
    event.preventDefault()
    form = $("#add-field").attr("data-form-content")
    new_num = $('.custom-field').length
    new_form = form.replace(/\[\d+?\]/g, "[#{new_num}]" ).replace(/\_\d+?\_/g, "_#{new_num}_")
    new_jq = $(new_form)
    #new_jq.find('.sort-order').val(new_num + 1)
    $("#input_fields_container").append new_jq
  $('#input_fields_container').on 'click', '.remove-new', ->
    $(@).parents('.custom-field').fadeOut 600, ->
      $(@).remove()
  $('#input_fields_container').on 'click', '.remove-exist', ->
    $(@).parents('.custom-field').fadeOut(600)
  $('.edit_activity, .new_activity').on 'submit', ->
    $('#input_fields_container').find('.sort-order').each (idx) ->
      $(@).val(idx + 1)
  $('#input_fields_container').sortable()
