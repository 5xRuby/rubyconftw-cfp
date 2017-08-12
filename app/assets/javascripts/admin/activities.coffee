jQuery ->
  if $('.edit_activity,.new_activity').length > 0
    $('.dpicker').datetimepicker
      format: "YYYY-MM-DD"
    $('.dtpicker').datetimepicker
      format: "YYYY-MM-DD hh:mm"
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
      $(@).parents('.custom-field').fadeOut 600, ->
        $(@).hide()
    $('.edit_activity, .new_activity').on 'submit', ->
      $('#input_fields_container').find('.sort-order').each (idx) ->
        $(@).val(idx + 1)
    $('#input_fields_container').sortable()
    $('.well .field-types input:checked').trigger('click')
    $('.well').find('.activity_custom_fields_collection_text').removeClass('hidden')   
    $('.edit_activity, .new_activity').on 'click', '.field-types input[type="radio"]', (e) ->
      acfct = $(@).parents('.well:first').find('.activity_custom_fields_collection_text')
      if $(@).val() == 'checkboxes' || $(@).val() == 'radios' || $(@).val() == 'selects'
        acfct.removeClass('hidden')
      else
        acfct.addClass('hidden')
    # show field that match the data-service-name
    $('#notifiers_container').on 'click', ".notifier .service-name-container input[type='radio']", ->
      notifier = $(@).parents(".notifier:first")
      service_name = notifier.find(".service-name-container input[type='radio']:checked").val()
      notifier.find(".service-info").each (idx) ->
        if !!service_name and $(@).data("service-name") == service_name
          $(@).removeClass('hidden')
        else
          $(@).addClass('hidden')
    $('.notifier .service-name-container input[type="radio"]:checked').trigger 'click'
    # add new notifier
    $("#add-notifier").on "click", (event) ->
      event.preventDefault()
      form = $("#add-notifier").attr("data-form-content")
      new_num = $('.notifier').length
      new_form = form.replace(/\[\d+?\]/g, "[#{new_num}]" ).replace(/\_\d+?\_/g, "_#{new_num}_")
      $("#notifiers_container").append new_form
    $('#notifiers_container').on 'click', '.remove-new', ->
      $(@).parents('.notifier').fadeOut 600, ->
        $(@).remove()
    $('#notifiers_container').on 'click', '.remove-exist', ->
      $(@).parents('.notifier').fadeOut 600, ->
        $(@).hide()
