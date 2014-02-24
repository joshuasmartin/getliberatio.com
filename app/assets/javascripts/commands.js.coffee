$ ->


  # Creates the command object on the server and sends the
  # command to the given node via Pusher WebSocket
  $("a.command-execute").on('click', (event) ->
    link = $(this)

    link.text("Working...")
    link.attr("disabled", true)

    $("#command_executable").attr("disabled", true)
    $("#command_arguments").attr("disabled", true)

    $("#command_executable").css("color", "#888888")
    $("#command_arguments").css("color", "#888888")

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
        # $("#modal-execute-command").modal("hide")
  )
