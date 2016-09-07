jQuery ->

 $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').hide()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")
  
 $('.question').children('.tack_back_voice').bind 'ajax:complete', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  alert json_mark
  

 $(document).on "turbolinks:load", () ->
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

$(document).ajaxComplete () ->
 $('.button-answer').click () ->
  $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

#$('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
# $('<h2>hello</h2>').insertBefore('.question')
# answer = JSON.parse(xhr.responseText)
# answer.id.appendTo('.question')
#$('.question').children('.rate-form').children('form').ajaxComplete () ->
#$(document).ajaxSuccess () ->
# $('<h2>hello</h2>').insertBefore('.question')
# parsedData = JSON.parse()
#$(document).ajaxSuccess (event, xhr, settings) ->
# alert xhr.responseText
 #$('.question').children('.rate-form').children('form.new_vote').bind "ajax:success", (event, data, xhr, settings) ->
  #alert "hi"
# $('<h2>hello</h2>').insertBefore('.question')

#$('.question').children('.rate-form').children('form').ajaxSuccess ( event, request, settings ) -> 
# alert request
#  $( "<li>Successful Request!</li>" ).appendTo( '.question' )


# $('.button-answer').click () ->
#   $(this).parent('.answer').children('.edit_answer_form').fadeToggle()

#  $('.button').click () ->
#   $(this).parent('.question').children('.edit_question_form').fadeToggle()
#--------------Nested-Attributes------------------------------------------------------
#$(document).on 'click', 'form .remove_field', (event) ->
#
#    $(this).prev('input[type=hidden]').val('1')
#    $(this).closest('fieldset').fadeOut(900)
#    event.preventDefault()
#
#  x = 0
#  $('form').on 'click', '.add_fields', (event) ->
#    event.preventDefault()
#    time = new Date().getTime()    
#    regexp = new RegExp(
#    	$(this).data('id'), 'g'
#    )
#
#    $(this).before(
#        $(this).data('fields').replace(regexp, time)
#    )
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