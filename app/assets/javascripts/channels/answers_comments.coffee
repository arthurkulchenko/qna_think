$(document).ready ->
 question_id = $(".question").attr('id')
 App.answers_comments = App.cable.subscriptions.create { channel: "AnswersCommentsChannel", question: question_id },
   connected: ->
     @perform('start_stream')
     # Called when the subscription is ready for use on the server
 
   disconnected: ->
     console.log("You are disconnected from AnswersCommentsChannel")
     # Called when the subscription has been terminated by the server
 
   received: (data) ->
     # Called when there's incoming data on the websocket for this channel
     delLink = '<a class="comment-delete-link" data-remote="true" rel="nofollow" data-method="delete" href="/comments/' + data.id + '">Delete my comment</a>'
     comment_content = "<div class='comment' id='comment_" + data.id + "'><p>User " + data.user_id + " says:</p><strong>" + data.content + "</strong><br>" + delLink + "</div>"
     $(".answers").find("#answer_" + data.parent_id).children(".comments").last().append(comment_content)
     $('.answer').find('#comment_content').val('')
     $('.comment').children('.comment-delete-link').click () ->
      $(this).parent('.comment').fadeOut()
      $(this).parent('.comment').remove()