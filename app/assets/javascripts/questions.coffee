jQuery ->
##------------------VOTE-------------------------
 $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').remove()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")
#-------------------VOTE-------------------------
 $(document).on "turbolinks:load", () ->
  $('.edit_question_form').hide()
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

  $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
   json_mark = JSON.parse(xhr.responseText).mark
   $(this).closest('.rate-form').children('p').remove()
   $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")