jQuery ->
  $('.add-tag-button').on 'click', ->
    form = $(this).attr('data-form-content')
    $(this).after(form)



