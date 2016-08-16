jQuery ->
  $('.edit-tag-button').on 'click', ->
    form = $(this).attr('data-form-content')
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').html(form)

    $('.remove-tag-field').on 'click', (e) ->
      e.preventDefault
      id = $(this).attr('data-id')
      $('.field-container[data-id='+id+']').html("")




