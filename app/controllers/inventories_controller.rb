# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class InventoriesController < ApplicationController

  protect_from_forgery except: :create
  skip_before_filter :authenticate_user!
  before_filter :authenticate_node!

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
    #   applications: [
    #                   {
    #                     name: '7-zip',
    #                     publisher: '7-zip',
    #                     version: '4.65'
    #                   }
    #                 ]
    # }
    @node.inventory(inventory_params)

    respond_to do |format|
      if @node
        format.json { render @node, status: :created, location: @node }
      else
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end

  rescue => error
    render :json => { errors: error }, :status => :unprocessable_entity
  end

  private
    def inventory_params
      params.require(:inventory).permit!
    end

    def authenticate_node!
      raise "Must provide a UUID and token" if (inventory_params[:uuid].blank? || inventory_params[:token].blank?)
      @node = Node.where(uuid: inventory_params[:uuid]).first!
      raise "Token is invalid, re-register the node" if @node.token != inventory_params[:token]
    end
end
