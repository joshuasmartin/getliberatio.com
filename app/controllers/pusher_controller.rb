# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action
  skip_before_filter :authenticate_user!, only: [:auth]

  def auth
    uuid = params[:channel_name].split("cmd_")[1]
    node = Node.where(uuid: uuid, token: params[:token]).first

    raise "Valid token must be provided for given device UUID" if node.blank?

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
      :user_id => node.id, # => required
      :user_info => { # => optional - for example
      }
    })
    render :json => response
  rescue => e
    render :text => "Forbidden", :status => '403'
  end
end
