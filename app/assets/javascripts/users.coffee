jQuery ->
  $(document).ready ->
    $("#user-digest-subscription").click ->
      $(this).parent().submit()