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
    if gon.current_user isnt '' then current_user = gon.current_user 
    
    simple_answer = '<div class="answer"><div class="answer-content"><strong>' + data.content + '</strong></div></div>'
    answer = "<div class='answer-content'><strong>"#{ j data.content }"</strong></div>"#{ j render partial: 'answers/best_voting', locals: { answer: data }}""#{ j render partial: 'layouts/rating', locals: { parent_object: data }}""#{ j render partial: 'layouts/attached_files', locals: { parent_object: data }}""
    comments =  "<div class='comments'><div class='comment'></div>"#{ j render answer.comments }""#{ render partial: 'answers/edit', locals: { answer: answer }}"</div><div class='new_comment'>"#{ j render partial: 'comments/new', locals: { parent_object: data }}"</div>"
    $('.answers').last('.answer').append(simple_answer)

    $('.edit_answer_form').hide()
    $('.attached-files').hide()
    $('#answer_content').val('')