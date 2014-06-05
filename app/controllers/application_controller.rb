# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
        @current_user = nil
      end
    end

    # helper should be protected
    helper_method :current_user

    # users can be located in any given timezone, so we allow them
    # to have their own and have it set every time they login
    def set_user_time_zone
      Time.zone = current_user.time_zone unless ((current_user.nil?) || (current_user.is? "Root"))
    end

    # Requires that a logged-in user must be present
    def authenticate_user!
      # if session is empty, redirect to root path
      if session[:user_id].nil?
        session[:requested_url] = request.url
        flash[:alert] = "You are not authorized to perform that action!"
        redirect_to root_path
      end
    end

    def require_subscription!
      if current_user.organization.subscriptions.none?
        flash[:alert] = "You can't do that because you don't have a subscription!"
        redirect_to settings_user_path(current_user)
      end
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform that action."
      redirect_to(request.referrer || root_path)
    end
end
