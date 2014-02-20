# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class NodesController < ApplicationController
  protect_from_forgery except: :register
  skip_before_filter :authenticate_user!, only: [:register, :registered]
  before_action :set_highlight
  before_action :set_node, only: [:show, :edit, :update, :destroy]

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

  # POST /nodes/register
  def register
    @organization = Organization.where(registration_code: params[:registration_code]).first!
    
    raise "Must provide a uuid" if !params.has_key?(:uuid)

    # since the registration code matches, we create
    # or update the node with a token to be returned
    @node = Node.update_or_create_from_uuid(uuid: params[:uuid],
                                            registration_code: @organization.registration_code)

    render :json => @node.to_json( :only => [:uuid, :token] ), :status => :ok
  rescue ActiveRecord::RecordNotFound
    render :json => { :errors => [ "Registration Code is invalid" ] }, :status => :unprocessable_entity
  rescue => error
    render :json => { :errors => error }, :status => :unprocessable_entity
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
        format.html { redirect_to @node, notice: 'Device was successfully added.' }
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
        format.html { redirect_to @node, notice: 'Device was successfully updated.' }
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
