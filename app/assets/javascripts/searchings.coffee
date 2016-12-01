jQuery ->
  $('#search_form').bind 'ajax:complete', (e, data, status, xhr) ->
    $(".search_result").children().remove()
    res = JSON.parse(data.responseText)
    #if res == null
    # alert "null result"
    iterator = res[Symbol.iterator]()
    loop
      result = iterator.next()
      if result.done
        break
      if result.value.email
        $(".search_result").append("<table><tr><td>Type</td><td>Content</td></tr><tr><td><p>User</p></td><td><p>"+result.value.email+"</p></td></tr></table>")
      if result.value.content != "Nothing is found"
        #alert Object.getOwnPropertyNames(result.value)
        $(".search_result").append("<table><tr><td>Type</td><td>Content</td></tr><tr><td><p>"+result.value.class_name+"</p></td><td><p>"+result.value.content+"</p></td></tr></table>")
      if result.value.content == "Nothing is found"
        $(".search_result").append(result.value.content)