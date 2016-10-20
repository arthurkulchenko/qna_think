App.question = App.cable.subscriptions.create "QuestionChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    alert data['message']

  new_question: (message) ->
    @perform 'new_question', message: message
