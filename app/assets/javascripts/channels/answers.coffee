$(document).ready ->
 question_id = $(".question").attr('id')
 App.answers = App.cable.subscriptions.create { channel: "AnswersChannel", question: question_id },
   connected: ->
     #"QuestionsChannel".unsubscribe()
     #App.cable.subscriptions.subscriptions[0].unsubscribe()
     console.log "You are connected to 'AnswersChannel'"
     #@perform('start_stream_answers', question_id: question_id)
     @perform('start_stream_answers')
 
   disconnected: ->
     # Called when the subscription has been terminated by the server
 
   received: (data) ->
    alert typeof(data)
    $('.answers').last('.answer').append(data)
    #$('#<%= dom_id(@answer)%>').children('.comments').prepend(edit)
    # Called when there's incoming data on the websocket for this channel
    $('.edit_answer_form').hide()
    $('.attached-files').hide()
    $('#answer_content').val('')