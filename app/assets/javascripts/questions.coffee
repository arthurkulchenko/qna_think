# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready () ->
 $('.answer').children('a').click () ->
  $(this).parent('.answer').remove()
 $('.edit_answer_form').hide()
 $('.edit_answer_link').click () ->
  $(this).parent('.answer').children('.edit_answer_form').fadeIn()