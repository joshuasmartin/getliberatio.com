# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Node < ActiveRecord::Base
  # relationships
  belongs_to :organization
  has_many :instances

  # validations
  validates :role, :name, :operating_system, :organization, presence: true
  validates :role, :inclusion => {:in => ["Workstation", "Server", "Domain Controller"]}

  def self.create_or_update_from_inventory(inventory, registration_code)
    organization = Organization.where(registration_code: registration_code).first
    node = where(uuid: inventory[:uuid]).first

    if node.blank?
      node = organization.nodes.create(inventory.except(:applications))
    else
      node.update(inventory.except(:uuid, :applications))
    end

    inventory[:applications].each do |a|
      application = Application.find_or_create_by( name: a[:name],
                                                   publisher: a[:publisher],
                                                   version: a[:version] )

      node.instances.find_or_create_by(application_id: application.id, organization_id: organization.id)
    end

    return node
  end

end
