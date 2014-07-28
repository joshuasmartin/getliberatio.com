# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class HostedFilesController < ApplicationController
  before_action :require_subscription!
  before_action :set_highlight
  before_action :set_navigation
  before_action :set_organization
  before_action :set_hosted_file, only: [:show, :edit, :update, :destroy]

  # GET /organizations/1/hosted_files
  # GET /nodes/1/hosted_files
  def index
    if @organization
      @hosted_files = @organization.hosted_files
    elsif @node
      @hosted_files = @node.hosted_files
    end
  end

  # GET /organizations/1/hosted_files/1
  # GET /nodes/1/hosted_files/1
  def show
  end

  # GET /organizations/1/hosted_files/new
  # GET /nodes/1/hosted_files/new
  def new
    @hosted_file = HostedFile.new
  end

  # GET /organizations/1/hosted_files/1/edit
  # GET /nodes/1/hosted_files/1/edit
  def edit
  end

  # POST /organizations/1/hosted_files
  # POST /nodes/1/hosted_files
  def create
    @hosted_file = HostedFile.new(hosted_file_params)

    respond_to do |format|
      if @hosted_file.save
        format.html { redirect_to @hosted_file, notice: 'Hosted file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hosted_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @hosted_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1/hosted_files/1
  # PATCH/PUT /nodes/1/hosted_files/1
  def update
    respond_to do |format|
      if @hosted_file.update(hosted_file_params)
        format.html { redirect_to @hosted_file, notice: 'Hosted file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hosted_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1/hosted_files/1
  # DELETE /nodes/1/hosted_files/1
  def destroy
    @hosted_file.destroy
    respond_to do |format|
      format.html { redirect_to hosted_files_url }
      format.json { head :no_content }
    end
  end

  private
    # Common setup and constraints.
    def set_hosted_file
      if params.has_key? :organization_id
        @hosted_file = @organization.hosted_files.find(params[:id])
      elsif params.has_key? :node_id
        @hosted_file = @node.hosted_files.find(params[:id])
      end
    end

    # Common setup and constraints.
    def set_node
      if params.has_key? :node_id
        @node = Node.find(params[:node_id])
      end
    end

    # Common setup and constraints.
    def set_organization
      if params.has_key? :organization_id
        @organization = Organization.find(params[:organization_id])
      end
    end

    def set_highlight
      @highlight = "devices"
    end

    def set_navigation
      @navigation = "account"
    end

    # Only allow a trusted parameter "white list" through.
    def hosted_file_params
      params.require(:hosted_file).permit(:node_id, :organization_id, :file_name, :friendly_name, :s3_url)
    end
end
