class CommandsController < WebsocketRails::BaseController

  #
  # {
  #   uuid: '05a27fe0-7f25-11e3-b9de-0002a5d5c51b'
  # }
  def create
    # inventory = Node.create_or_update_from_inventory(message)
    puts message
    send_message :create_success, "Success", :namespace => :commands

    # if task.save
    #   send_message :create_success, task, :namespace => :inventories
    # else
    #   send_message :create_fail, task, :namespace => :inventories
    # end
  end
  
end