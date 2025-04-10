# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!

  # GET /sessions/new
  def new
    session[:signup] = true if params.has_key? :signup
  end

  # POST /sessions
  def create
    # we don't want the session to keep old stuff
    # reset_session

    user = User.where(email_address: params[:email_address].downcase).first

    respond_to do |format|
      if user && user.authenticate(params[:password]) # authenticated
        format.html {
          session[:user_id] = user.id
          redirect_to dashboard_nodes_path
          # # Continue sign up if a plan is in the session
          # if session.has_key? :signup
          #   redirect_to new_subscription_path
          # else
          #   redirect_to root_path
          # end
        }
        format.json { render :json => user.as_json( :only => [:api_key, :api_secret] ) }
      else
        format.html {
          flash.now.alert = "Invalid E-mail address or password"
          render :new
        }
        format.json { render :json => { :error => "Invalid E-mail address or password" } }
      end
    end
  end

  # DELETE /sessions/destroy
  def destroy
    session[:user_id] = nil

    # we don't want the session to keep old stuff
    reset_session
    
    redirect_to root_path
  end

end
