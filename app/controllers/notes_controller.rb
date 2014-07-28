# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class NotesController < ApplicationController
  before_action :require_subscription!
  before_action :set_highlight
  before_action :set_navigation
  before_action :set_node
  before_action :set_organization
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /organizations/1/notes
  # GET /nodes/1/notes
  def index
    if @organization
      @notes = @organization.notes
    elsif @node
      @notes = @node.notes
    end
  end

  # GET /organizations/1/notes/1
  # GET /nodes/1/notes/1
  def show
  end

  # GET /organizations/1/notes/new
  # GET /nodes/1/notes/new
  def new
    @note = Note.new
  end

  # GET /organizations/1/notes/1/edit
  # GET /nodes/1/notes/1/edit
  def edit
  end

  # POST /organizations/1/notes
  # POST /nodes/1/notes
  def create
    if @organization
      @note = @organization.notes.new(note_params)
    elsif @node
      @note = @node.notes.new(note_params)
    end

    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1/notes/1
  # PATCH/PUT /nodes/1/notes/1
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1/notes/1
  # DELETE /nodes/1/notes/1
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Common setup and constraints.
    def set_note
      if params.has_key? :organization_id
        @note = @organization.notes.find(params[:id])
      elsif params.has_key? :node_id
        @note = @node.notes.find(params[:id])
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
    def note_params
      params.require(:note).permit(:node_id, :organization_id, :title, :contents, :user_id)
    end
end
