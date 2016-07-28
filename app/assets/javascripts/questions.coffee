# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $(document).ready () ->
#  $('.edit_question_form').hide()
#  $('.edit_answer_form').hide()
 
  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').remove()