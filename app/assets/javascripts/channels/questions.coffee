App.questions = App.cable.subscriptions.create "QuestionsChannel",
  connected: ->
    console.log "You are connected to 'QuestionsChannel'"
    @perform 'start_stream'

  disconnected: ->
    console.log("You are disconnected from QuestionsChannel")
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('.notice-message').remove()
    $('.question-list').last('.question-link').append(data)
    $('.new_question').before("<h3 class='notice-message'>Please wait for a while, someone will answer you soon.</h3>")
    $('#question_title').val('')
    $('#question_content').val('')