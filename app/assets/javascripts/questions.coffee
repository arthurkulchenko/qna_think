# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $(document).ready () ->
  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').remove()
 $('.button').click () ->
  $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

#  // $('.answer').children('.appear_link').click () ->
#  //  $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
  
  $('.answer').children('.vote_answer_form').children('#answer_best_answer').click () ->
    alert('hi')
#    $(this).parent('.vote_answer_form').children('form').submit()
 $('.vote_answer_form').children('input').click () ->
  alert('hi')

# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').submit()
# $('.answers').children('.answer').first().children('.vote_answer_form').children('form').children('#answer_best_answer').prop("checked");