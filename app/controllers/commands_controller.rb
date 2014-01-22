class CommandsController < WebsocketRails::BaseController

  # Creates or updates the database with the given inventory payload.
  # The data received from the Liberatio client should resemble:
  #
  # {
  #   uuid: '05a27fe0-7f25-11e3-b9de-0002a5d5c51b',
  #   role: 'Server',
  #   location: 'My Office',
  #   name: 'station-01',
  #   operating_system: 'Windows XP Professional SP3',
  #   serial_number: 'ABC123',
  #   model_number: 'MacBook Pro Early 2011',
  #   applications: { 
  #                   application: {
  #                                  name: '7-zip',
  #                                  publisher: '7-zip',
  #                                  version: '4.65'
  #                                }
  #                 }
  # }
  def create
    inventory = Node.create_or_update_from_inventory(message)
    send_message :create_success, "Success", :namespace => :inventories

    # if task.save
    #   send_message :create_success, task, :namespace => :inventories
    # else
    #   send_message :create_fail, task, :namespace => :inventories
    # end
  end
  
end