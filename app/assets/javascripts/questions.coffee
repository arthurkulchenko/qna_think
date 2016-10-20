jQuery ->
##------------------VOTE-------------------------
 $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').remove()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")
#-------------------VOTE-------------------------
 $(document).on "turbolinks:load", () ->
  $('.edit_question_form').hide()
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

  $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
   json_mark = JSON.parse(xhr.responseText).mark
   $(this).closest('.rate-form').children('p').remove()
   $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")

App.questions = App.cable.subscriptions.create "QuestionsChannel",
  connected: ->
    console.log "You are connected to 'QuestionsChannel'"
    @perform 'start_stream'
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('.notice-message').remove()
    $('.question-list').last('.question-link').append(data)
    $('.new_question').before("<h3 class='notice-message'>Please wait for a while, someone will answer you soon.</h3>");
    #alert data
    $('#question_title').val('')
    $('#question_content').val('')
    # Called when there's incoming data on the websocket for this channel