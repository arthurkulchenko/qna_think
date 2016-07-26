# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $(document).ready () ->
  $('.edit_answer_form').hide()
 
  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').remove()
 
  $('.answer').children('.edit_answer_link').click () ->
   $(this).closest('.edit_answer_form').fadeToggle()
 
  $('.div').click () ->
   $(this).fadeOut