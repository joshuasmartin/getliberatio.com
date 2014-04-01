# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class PusherController < ApplicationController
  protect_from_forgery :except => [:auth, :webook] # stop rails CSRF protection for this action
  skip_before_filter :authenticate_user!, only: [:auth, :webook]

  # POST /pusher/auth
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

  # POST /pusher/webhook
  def webhook
    webhook = Pusher::WebHook.new(request)
    if webhook.valid?
      webhook.events.each do |event|
        case event["name"]
        when 'member_added'
          Node.update_status(id: event["user_id"], status: 'online')
        when 'member_removed'
          Node.update_status(id: event["user_id"], status: 'offline')
        end
      end
      render text: 'ok'
    else
      render text: 'invalid', status: 401
    end
  end
end
