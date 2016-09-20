jQuery ->
# currentUser = gon.current_user
# questionId = (/[\d]+/g).exec(window.location.pathname)[0]
# channel_of = "/questions/" + questionId + "/answers"
 #
# PrivatePub.subscribe channel_of, (data, channel) ->
#  #$('.answers').last('.answer').append(data.answer.content)
#  answer_obj = data.answer
#  $('.answers').last('.answer').append("<%= j render template: 'answers/answer', locals: {answer: answer_obj } %>")
 $('.new_answer').bind 'ajax:error', (e, xhr, status, error) ->
  errors = JSON.parse(xhr.responseText)
  alert errors
  
 $('.edit_answer_form').bind 'ajax:error', (e, xhr, status, error) ->
  errors = JSON.parse(xhr.responseText)
  alert errors

#  jQuery.each errors, (index, value) ->
#   $( "#" + value ).text( "Mine is " + value + "." );
#   $(this).text(value)

 $('.answer').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').hide()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")
 $('.answer').children('.tack_back_voice').bind 'ajax:complete', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  alert json_mark

 $('.answer-check-box').click () ->
  $(this).parent('form').submit()

 $(document).on "turbolinks:load", () ->
  $('.edit_answer_form').hide()
  $('.attached-files').hide()

  $('.answer').children('.delete_answer_link').click () ->
   $(this).parent('.answer').fadeOut()
   $(this).parent('.answer').remove()

  $('.button-answer').click () ->
   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
  $('.submit-button').click () ->
   $(this).parent('.answer').hide()

#-------------
#  $('.button').click () ->
#   $(this).parent('.question').children('.edit_question_form').fadeToggle()

#------------------------------------------------------------------------------------
# $(document).ajaxComplete () ->
#  $('.vote_answer_form').children('input').children('#answer_best_answer').click () ->
#   alert "hellllllooooooo"
#   $(this).parent('form').submit
   #
#  $('.button-answer').click () ->
#   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()
#  $('.submit-button').click () ->
#   $(this).parent('.answer').hide() 
#
#  $('.answer').children('.delete_answer_link').click () ->
#   $(this).parent('.answer').fadeOut()
#   $(this).parent('.answer').remove()
#
#  $('.button-answer').click () ->
#   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()