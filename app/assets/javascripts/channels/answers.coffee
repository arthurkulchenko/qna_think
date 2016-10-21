App.answers = App.cable.subscriptions.create "AnswersChannel",
  connected: ->
    console.log "You are connected to 'AnswersChannel'"
    @perform('start_stream_answers', question_id: gon.question.id)

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('.answers').last('.answer').append(data)
    #$('#<%= dom_id(@answer)%>').children('.comments').prepend(edit)
    # Called when there's incoming data on the websocket for this channel
    $('.edit_answer_form').hide()
    $('.attached-files').hide()
    $('#answer_content').val('')