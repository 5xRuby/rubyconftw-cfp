jQuery ->
  $('.edit-tag-button').on 'click', ->
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').removeClass("hide")

  $('.remove-tag-field').on 'click', (e) ->
    e.preventDefault
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').addClass("hide")




