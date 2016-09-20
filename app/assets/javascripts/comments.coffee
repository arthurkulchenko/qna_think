jQuery ->
 $('.comment').children('.comment-delete-link').click () ->
   $(this).parent('.comment').fadeOut()
   $(this).parent('.comment').remove()

 $('.new_comment').bind 'ajax:error', (e, xhr, status, error) ->
  errors = JSON.parse(xhr.responseText)
  alert errors