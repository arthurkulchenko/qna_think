# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $(document).ready () ->
#  $('.edit_question_form').hide()
#  $('.edit_answer_form').hide()

#  check_cheker = (check_box) ->
#    if check_box.prop("checked") == previose_stance
#    else
#     check_box.parent('form').submit()
#    end
 
  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').remove()
  
#  $('.answer').children('.vote_answer_form').children('#answer_best_answer').click () ->
#    alert('hi')
#    $(this).parent('.vote_answer_form').children('form').submit()

# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').submit()
# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').children('#answer_best_answer').prop("checked");