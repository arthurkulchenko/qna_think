jQuery ->
  $("#new_subscribtion").bind 'ajax:success', (e, data, status, xhr) ->
    alert "Now You are Subscribed"
  $("#unsubscribe").bind 'ajax:success', (e, data, status, xhr) ->
    alert "Now You are Unsubscribed"