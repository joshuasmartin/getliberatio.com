$ ->

  $("a.command-regenerate_registration_code").on('click', (event) ->
    $.get("/organizations/regenerate_registration_code", (data) ->
      $(".registration-code strong").html(data.registration_code)
    )
  )