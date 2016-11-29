jQuery ->
  $('#search_form').bind 'ajax:complete', (e, data, status, xhr) ->
    $(".search_result").children().remove()
    res = JSON.parse(data.responseText)
    iterator = res[Symbol.iterator]()
    loop
      result = iterator.next()
      if result.done
        break
      if result.value.email
        $(".search_result").append("<table><tr><td>Type</td><td>Content</td></tr><tr><td><p>User</p></td><td><p>"+result.value.email+"</p></td></tr></table>")
      if result.value.content
        #alert Object.getOwnPropertyNames(result.value)
        $(".search_result").append("<table><tr><td>Type</td><td>Content</td></tr><tr><td><p>"+result.value.class_name+"</p></td><td><p>"+result.value.content+"</p></td></tr></table>")