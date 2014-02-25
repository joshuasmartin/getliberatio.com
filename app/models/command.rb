# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Command < ActiveRecord::Base
  # callbacks
  # after_create :trigger_event

  # relationships
  belongs_to :node

  # Returns a hash whose content depends on the 'kind' of command this is.
  def to_pusher_json
    case self.kind
    when "builtin"
      { commands: { name: self.name } }
    when "custom"
      { commands: { executable: self.executable, arguments: self.arguments } }
    end
  end

  # Triggers the 'commands.run' event on all clients on the private channel
  # belonging to the device. It checks first to see that the device is ready.
  def trigger_event
    begin
      Pusher.trigger("private-cmd_#{self.node.uuid}", "commands.run", self.to_pusher_json)
    rescue Pusher::Error => error
      logger.error error.message
      self.output << "Error executing command"
      self.output << error.message
    end
  end
end
