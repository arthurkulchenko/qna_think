jQuery ->
 $(document).ready () ->
  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').remove()

 $('.button-answer').click () ->
  $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

 $('.button').click () ->
  $(this).parent('.question').children('.edit_question_form').fadeToggle()

checking_box = ->
 $('.vote_answer_form').children('input[type=checkbox]').click () ->
  $(this).parent('form').submit()

$(document).on "turbolinks:update", () ->
 alert 'hi'
 $('.vote_answer_form').children('input[type=checkbox]').click () ->
  $(this).parent('form').submit()


 $(document).on "turbolinks:load", (e) ->
  e.preventDefault()
  $('.button-answer').click () ->
   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

 $(document).on "turbolinks:update", () ->
  e.preventDefault()

  $('.button-answer').click () ->
   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

  $('.edit_answer_form').hide();


#  $('.answer').children('.vote_answer_form').children('#answer_best_answer').click () ->
#   alert('hi')
#    $(this).parent('.vote_answer_form').children('form').submit()
# $('.vote_answer_form').children('input').click () ->
#  alert('hi')
# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').submit()
# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').children('#answer_best_answer').prop("checked");