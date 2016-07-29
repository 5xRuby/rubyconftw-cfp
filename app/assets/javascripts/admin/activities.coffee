jQuery ->
  $("#add-field").on "click", (event) ->
    event.preventDefault()
    ta1 =  /activity_custom_fields_attributes_\d/
    ta2 =  /activity\[custom_fields_attributes\]\[\d/
    ta3 = /custom_field_\d/
    num = Math.floor(Math.random() * (1000 - 100)) + 100
    re1 = "activity_custom_fields_attributes_" + num
    re2 = "activity[custom_fields_attributes][" + num
    re3 = "new_custom_field"
    form = $("#field-content").html()
    form = form.split(ta1).join(re1).split(ta2).join(re2).split(ta3).join(re3)
    $("#input_fields_container").append(form)
  $('input[type=submit]').on "click", ->
    $('.hidden').html("")
