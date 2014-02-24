# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Command < ActiveRecord::Base
  # callbacks
  after_create :trigger_event

  # relationships
  belongs_to :node

  def to_pusher_hash
    { commands: { builtin: "reboot" } }
  end

  def trigger_event
    begin
      Pusher.trigger("private-cmd_#{self.node.uuid}", "commands.run", self.to_pusher_hash)
    rescue Pusher::Error => error
      logger.error error.message
      self.output << "Error executing command"
      self.output << error.message
    end
  end
end
