$ ->


  $("#command_kind").on('change', (event) ->
    value = $(this).val()

    switch value
      when "builtin"
        $(".page-custom").hide()
        $(".page-builtin").show()
      when "custom"
        $(".page-builtin").hide()
        $(".page-custom").show()
  )


  $("#command_kind").change()


  # Creates the command object on the server and sends the
  # command to the given node via Pusher WebSocket
  $("a.command-execute").on('click', (event) ->
    link = $(this)

    # switch the form to non-editable
    switchForm("off")

    $("#command_output").val("Sending command to device..")

    json = JSON.stringify({
      command: {
        executable: $("#command_executable").val(),
        arguments: $("#command_arguments").val()
      }
    })

    $.ajax "/nodes/#{link.data("node_id")}/commands",
      type: 'POST',
      contentType: 'application/json',
      data: json,
      dataType: 'json', 
      error: (jqXHR, textStatus, errorThrown) ->
        $("#command_output").val(textStatus)
        console.log "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        switchForm("on")
        # $("#modal-execute-command").modal("hide")
  )

  switchForm = (onOrOff) ->
    switch onOrOff
      when "on"
        $(".command-execute").text("Execute")
        $(".command-execute").attr("disabled", false)

        $("img.waiting").hide()

        $("#command_kind").attr("disabled", false)
        $("#command_executable").attr("disabled", false)
        $("#command_arguments").attr("disabled", false)
        $("#command_kind").css("color", "#000000")
        $("#command_executable").css("color", "#000000")
        $("#command_arguments").css("color", "#000000")
      when "off"
        $(".command-execute").text("Working...")
        $(".command-execute").attr("disabled", true)

        $("img.waiting").show()

        $("#command_kind").attr("disabled", true)
        $("#command_executable").attr("disabled", true)
        $("#command_arguments").attr("disabled", true)
        $("#command_kind").css("color", "#888888")
        $("#command_executable").css("color", "#888888")
        $("#command_arguments").css("color", "#888888")


  # Sets the 'kind' select to 'custom' and shows the modal
  $("a.command-show-modal-custom").on('click', (event) ->
    $("#command_kind").val("custom")
    $("#command_kind").change()
    $("#modal-execute-command").modal("show")
  )


  # Sets the 'kind' select to 'builtin' and shows the modal
  $("a.command-show-modal-reboot").on('click', (event) ->
    $("#command_kind").val("builtin")
    $("#command_kind").change()
    $("#modal-execute-command").modal("show")
  )


  # Sets the 'kind' select to 'builtin' and shows the modal
  $("a.command-show-modal-shutdown").on('click', (event) ->
    $("#command_kind").val("builtin")
    $("#command_kind").change()
    $("#modal-execute-command").modal("show")
  )
