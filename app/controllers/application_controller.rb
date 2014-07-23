# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  around_filter :set_time_zone

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :beta?
  def beta?
    true
  end

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

    # Sets the user's time zone from his time_zone attribute.
    def set_time_zone
      if current_user
        Time.use_zone(current_user.time_zone) { yield }
      else
        yield
      end
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
      if false#current_user.organization.subscriptions.none?
        flash[:alert] = "You can't do that because you don't have a subscription!"
        redirect_to settings_user_path(current_user)
      end
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform that action."
      redirect_to(request.referrer || root_path)
    end
end
