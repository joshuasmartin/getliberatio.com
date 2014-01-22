# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class InventoriesController < ApplicationController

  protect_from_forgery except: :create

  # POST /inventories
  def create
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
    @node = Node.create_or_update_from_inventory(inventory_params[:inventory])

    respond_to do |format|
      if @node
        format.json { render @node, status: :created, location: @node }
      else
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def inventory_params
      params.permit(:inventory)
    end
  
end