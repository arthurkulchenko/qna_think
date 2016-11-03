jQuery ->

 $(document).on "turbolinks:load", () ->
  $(".edit_answer_form").hide()
  $('.submit-button').click () ->
   $(this).parent('.answer').hide()

  $('.button-answer').click () ->
   $(this).parent().children(".edit_answer_form").fadeToggle()
##-------------------------VOTING-----------------------------
 $('.answer').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').remove()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")

 $('.answer').children('.tack_back_voice').bind 'ajax:complete', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  alert json_mark
#--------------------------VOTING-----------------------------
 $('.vote-check-box').click () ->
  $(this).parent('form').submit()
#-------------------------DELETING----------------------------
 $('.delete_answer_link').click -> 
  parent = $(this).first().parents(".answer")
  parent.fadeOut()
  parent.remove()
 