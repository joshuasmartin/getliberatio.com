# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class NodesController < ApplicationController
  before_action :set_highlight
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:registered]

  respond_to :json

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = current_user.organization.nodes
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
  end

  def registered
    @node = Node.where(uuid: params[:uuid]).first
    
    if @node
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => :no_content
    end
  end

  # GET /nodes/new
  def new
    @node = current_user.organization.nodes.new
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = current_user.organization.nodes.new(node_params)
    @node.is_managed = false

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render action: 'show', status: :created, location: @node }
      else
        format.html { render action: 'new' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

  private
    def set_node
      @node = current_user.organization.nodes.find(params[:id])
    end

    def set_highlight
      @highlight = "devices"
    end

    def node_params
      params.require(:node).permit(:role, :location, :name, :operating_system, :serial_number, :model_number, :is_managed)
    end
end
