jQuery ->
 $('.comment').children('.comment-delete-link').click () ->
  $(this).parent('.comment').fadeOut()
  $(this).parent('.comment').remove()
  #$('#<%= dom_id(@comment) %>').fadeOut();
  #$('#<%= dom_id(@comment) %>').remove();