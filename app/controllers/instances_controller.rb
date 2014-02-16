# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class InstancesController < ApplicationController
  before_action :set_highlight
  before_action :set_instance, only: [:show, :edit, :update, :destroy]

  # GET /instances
  # GET /instances.json
  def index
    @instances = current_user.organization.instances
  end

  # GET /instances/1
  # GET /instances/1.json
  def show
  end

  # GET /instances/new
  def new
    @instance = Instance.new
  end

  # GET /instances/1/edit
  def edit
  end

  # POST /instances
  # POST /instances.json
  def create
    @instance = Instance.new(instance_params)

    respond_to do |format|
      if @instance.save
        format.html { redirect_to @instance, notice: 'Instance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @instance }
      else
        format.html { render action: 'new' }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instances/1
  # PATCH/PUT /instances/1.json
  def update
    respond_to do |format|
      if @instance.update(instance_params)
        format.html { redirect_to @instance, notice: 'Instance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instances/1
  # DELETE /instances/1.json
  def destroy
    @instance.destroy
    respond_to do |format|
      format.html { redirect_to instances_url }
      format.json { head :no_content }
    end
  end

  private
    def set_instance
      @instance = Instance.find(params[:id])
    end

    def set_highlight
      @highlight = "software"
    end

    def instance_params
      params.require(:instance).permit(:application_id, :node_id)
    end
end
