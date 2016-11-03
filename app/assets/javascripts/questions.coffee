jQuery ->
##------------------VOTE-------------------------
 $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).mark
  $(this).closest('.rate-form').children('p').remove()
  $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")
#-------------------VOTE-------------------------
 $(document).on "turbolinks:load", () ->
  $('.edit_question_form').hide()
  $('.button').click () ->
   $(this).parent('.question').children('.edit_question_form').fadeToggle()

  $('.question').children('.rate-form').children('form').bind 'ajax:success', (e, data, status, xhr) ->
   json_mark = JSON.parse(xhr.responseText).mark
   $(this).closest('.rate-form').children('p').remove()
   $(this).closest('.rate-form').prepend("<p>Total mark is: " + json_mark + "</p>")

#-------------------------DELETING----------------
 $('.delete_question_link').click -> 
  parent = $(this).first().parents(".question")
  parent.fadeOut()
  parent.remove()
#-------------------------UPDATE------------------
$('.question').children('.edit_question_form').bind 'ajax:success', (e, data, status, xhr) ->
  json_mark = JSON.parse(xhr.responseText).content
  alert content
  #$('.question_content').html('<h3><%= j @question.content %></h3>');
  $('.edit_question_form').hide();