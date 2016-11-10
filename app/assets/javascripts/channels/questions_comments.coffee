$(document).ready ->
 question_id = $(".question").attr('id')
 App.questions_comments = App.cable.subscriptions.create { channel: "QuestionsCommentsChannel", question: question_id },
   connected: ->
     @perform('start_stream')
     # Called when the subscription is ready for use on the server
 
   disconnected: ->
     # Called when the subscription has been terminated by the server
 
   received: (data) ->
     # Called when there's incoming data on the websocket for this channel
     delLink = '<a class="comment-delete-link" data-remote="true" rel="nofollow" data-method="delete" href="/comments/' + data.id + '">Delete my comment</a>'
     comment_content = "<p>User " + data.user_id + " says:</p><strong>" + data.content + "</strong><br>" + delLink
     $(".question").children(".comments").children('.comment').last().append(comment_content);
     $('#comment_content').val('');
     #-------------------------DELETING----------------
     $('.delete_question_link').click -> 
      parent = $(this).first().parents(".question")
      parent.fadeOut()
      parent.remove()