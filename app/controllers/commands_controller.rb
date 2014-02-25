# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class CommandsController < ApplicationController
  before_action :set_node, only: [:show, :create]

  # GET /nodes/1/commands/1.json
  def show
  end

  # POST /nodes/1/commands.json
  def create
    @command = @node.commands.new(command_params)

    respond_to do |format|
      if @command.save
        format.json { render action: 'show', status: :created, location: [@node, @command] }
      else
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_node
      @node = Node.find(params[:node_id])
    end

    def command_params
      params.require(:command).permit(:name, :kind, :executable, :arguments)
    end
end
