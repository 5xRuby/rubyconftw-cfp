jQuery ->
  $('.edit-tag-button').on 'click', ->
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').removeClass("hide")

  $('.remove-tag-field').on 'click', (e) ->
    e.preventDefault()
    id = $(this).attr('data-id')
    $('.field-container[data-id='+id+']').addClass("hide")
  $('.papers').on 'click', '.paper-tag', (e) ->
    e.preventDefault()
    tag_name = $(@).data("tag-name")
    $(".paper-tag[data-tag-name='#{tag_name}']").parents("tr").find("input[type=checkbox]").prop('checked', true)
    false
  $('.papers').on 'click', '.paper-state', (e) ->
    e.preventDefault()
    state = $(@).data 'state'
    $(".paper-state[data-state='#{state}']").parents('tr').find("input[type=checkbox]").prop 'checked', true
    false
  # For ajax comment 
  $("#new_comment").on 'ajax:success', (e, data, status, xhr) ->
    $("#comment-group").append(data)
    $("#new_comment #comment_text").val('')
    $("#comment_error").html("")
  $("#new_comment").on 'ajax:error', (e, data, status, xhr) ->
    $("#comment_error").html(data.responseJSON.reason)

  # For ajax tag saving
  $(".field-container").on 'ajax:success', (e, data, status, xhr) ->
    # Replace display tags
    $(".display_tags").html(data.display_tags_html)
    # Remove all Bootstrap tags
    $('.paper_tag_list > input').tagsinput('removeAll')
    # For each tag
    $.each data.tags, (index, tag)->
      # Bootstrap: add tags
      $('.paper_tag_list > input').tagsinput('add', tag)
    # close edit block
    $(".remove-tag-field").trigger 'click'

  # Toggle paper's checkbox
  $paper_checkboxes = $("input[name='notification[ids][]']")
  $check_all_checkbox = $('#notification_check_all')

  $check_all_checkbox.on 'click', (e) ->
    check_status = $check_all_checkbox.prop('checked')
    $paper_checkboxes.prop('checked', check_status) # Toggle it
  # For tags input
  window.CreateTagsInput = (element, url) ->
    source = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: {
          url: url,
          cache: false,
        }
    })
    source.initialize()
    $(element).tagsinput({
      freeInput: true,
      typeaheadjs: {
        source: source.ttAdapter()
        displayKey: 'name',
        hint: true,
        highlight: true,
        minLength: 0

      }
    })
  # tags in search bar
  $(".search_field select").on "change", ->
    if $(@).val() == "tag"
      # use tag-input
      show_div = $(".search_key .tag-input")
      hide_div = $(".search_key .normal-input")
    else
      # use normal-input
      show_div = $(".search_key .normal-input")
      hide_div = $(".search_key .tag-input")
    show_div.children(".input-field").attr("name", "search_key")
    show_div.removeClass("hidden")
    hide_div.children(".input-field").attr("name", "")
    hide_div.addClass("hidden")
  $(".search_field select").trigger "change"


