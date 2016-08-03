jQuery ->

 $(document).on "turbolinks:load", () ->
#
#  $('.answer').children('.delete_answer_link').click () ->
#   $(this).parent('.answer').fadeOut()
#   $(this).parent('.answer').remove()
#
#  $('.button-answer').click () ->
#   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
#
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

#------------------------------------------------------------------------------------
 $(document).on "turbolinks:update", () ->
 
  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').fadeOut()
   $(this).parent('.answer').remove()
 
  $('.button-answer').click () ->
   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
 
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

#------------------------------------------------------------------------------------
$(document).on "ajax:complete", () ->
# $('.button-answer').click () ->
#   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

#  $('.button').click () ->
#   $(this).parent('.question').children('.edit_question_form').fadeToggle()










#------------------------------------------------------------------------------------
# $(document).on "turbolinks:request-start", (e) ->
#  e.preventDefault()
#  $('.button-answer').click () ->
#   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
#  $('.button').click () ->
#   $(this).parent('.question').children('.edit_question_form').fadeToggle()
#  $('.edit_answer_form').hide();


#------------------------------------------------------------------------------------
# $(document).ready () ->
#  $('.answer').children('.delete_answer_link').click () ->
#   $(this).parent('.answer').fadeOut()
#   $(this).parent('.answer').remove()

# $('.edit_answer_form').hide();
# $('.edit_question_form').hide();


# $('.button-answer').click () ->
#  $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
#
# $('.button').click () ->
#  $(this).parent('.question').children('.edit_question_form').fadeToggle()

# $(document).on "turbolinks:update", () ->
#  $('.vote_answer_form').children('input[type=checkbox]').click () ->
#   $(this).parent('form').submit()


#checking_box = ->
# $('.vote_answer_form').children('input[type=checkbox]').click () ->
#  $(this).parent('form').submit()


#  $('.answer').children('.vote_answer_form').children('#answer_best_answer').click () ->
#   alert('hi')
#    $(this).parent('.vote_answer_form').children('form').submit()
# $('.vote_answer_form').children('input').click () ->
#  alert('hi')
# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').submit()
# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').children('#answer_best_answer').prop("checked");