jQuery ->
 $('.comment').children('.comment-delete-link').click () ->
   $(this).parent('.comment').fadeOut()
   $(this).parent('.comment').remove()
##-----------------NEW-COMMENT-AS-JSON--------------------
 $('.new_comment').bind 'ajax:error', (e, xhr, status, error) ->
  errors = JSON.parse(xhr.responseText)
  alert errors
 $('.new_comment').bind 'ajax:success', (e, data, status, xhr) ->
  comment = JSON.parse(xhr.responseText)
  $('.comment').last().append(comment.content)
#------------------NEW-COMMENT-AS-JSON--------------------