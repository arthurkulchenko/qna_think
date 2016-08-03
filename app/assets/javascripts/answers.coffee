jQuery ->
 $('.answer-check-box').click () ->
  $(this).parent('form').submit()

 $(document).on "turbolinks:load", () ->

  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').fadeOut()
   $(this).parent('.answer').remove()

  $('.button-answer').click () ->
   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
  $('.submit-button').click () ->
   $(this).parent('.answer').hide()

#  $('.button').click () ->
#   $(this).parent('.question').children('.edit_question_form').fadeToggle()

#------------------------------------------------------------------------------------
 $(document).on "turbolinks:visit", () ->

  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').fadeOut()
   $(this).parent('.answer').remove()

  $('.button-answer').click () ->
   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()