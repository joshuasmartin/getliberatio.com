# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_action :set_navigation
  before_action :set_user, only: [:show, :settings, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user.is? "Root"
      @users = User.all
    else
      raise Pundit::NotAuthorizedError
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/settings
  def settings
    @subscription = @user.organization.subscriptions.first
    if @subscription.present?
      @card = Stripe::Customer.retrieve(@subscription.stripe_customer_token).cards.all.first
    end
  end

  # GET /users/new
  def new
    @user = User.new
    session[:signup] = true if params.has_key? :signup

    if beta? && current_user
      flash[:notice] = "Congratulations, you already have Liberatio!"
      redirect_to dashboard_nodes_path
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {
          UserMailer.welcome_email(@user).deliver
          
          session[:user_id] = @user.id

          redirect_to welcome_subscriptions_path

          # # Continue sign up if a plan is in the session
          # if session.has_key? :signup
          #   redirect_to new_subscription_path
          # else
          #   redirect_to root_path
          # end
        }
      else
        flash[:alert] = @user.errors.full_messages
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          if params.has_key? :settings
            redirect_to settings_user_path(@user), notice: 'Changes saved sucessfully!'
          else
            redirect_to @user, notice: 'Changes saved sucessfully!'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_navigation
      if action_name == "edit"
        @navigation = "account"
      end
    end

    def user_params
      params.require(:user).permit(:email_address, :name, :password, :password_confirmation, :role, :organization_id, :organization_name)
    end
end
