jQuery ->

 $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').hide()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")

 $(document).on "turbolinks:load", () ->
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

$(document).ajaxComplete () ->
 $('.button-answer').click () ->
  $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
