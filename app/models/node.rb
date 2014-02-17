# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Node < ActiveRecord::Base
  # callbacks
  before_create :generate_uuid

  # relationships
  belongs_to :organization
  has_many :instances
  has_many :memories

  # validations
  validates :role, :name, :operating_system, :organization, presence: true
  validates :role, :inclusion => {:in => ["Domain Controller", "Phone", "Router", "Server", "Tablet", "Workstation"]}, :if => Proc.new { |node| node.role.present? }
  # validates :operating_system, :inclusion => {:in => Node.operating_systems}

  # validate :validate_operating_system_in_operating_systems
  # def validate_operating_system_in_operating_systems
  #   errors.add(:base, "Operating system is not valid") if not Node.operating_systems.include?(self.operating_system)
  # end


  def self.create_or_update_from_inventory(inventory, registration_code)
    organization = Organization.where(registration_code: registration_code).first
    node = where(uuid: inventory[:uuid]).first

    if node.blank?
      node = organization.nodes.create(inventory.except(:applications, :memory))
    else
      node.update(inventory.except(:uuid, :applications))
    end

    # applications
    inventory[:applications].each do |a|
      application = Application.find_or_create_by( name: a[:name],
                                                   publisher: a[:publisher],
                                                   version: a[:version] )

      node.instances.find_or_create_by(application_id: application.id, organization_id: organization.id)
    end

    # memories
    node.memories.destroy_all
    inventory[:memory].each do |m|
      node.memories << node.memories.new( capacity: m[:capacity],
                                          form_factor: m["FormFactor"],
                                          manufacturer: m[:manufacturer],
                                          memory_type: m["MemoryType"],
                                          speed: m[:speed])
      node.save
    end

    return node
  end


  def can_edit_special_field?
    if self.id.blank?
      return true
    else
      if self.is_managed?
        return false
      else
        return true
      end
    end
  end


  def self.operating_systems
    oses = []
    oses << "Red Hat Enterprise Linux 3"
    oses << "Red Hat Enterprise Linux 3.1"
    oses << "Red Hat Enterprise Linux 3.2"
    oses << "Red Hat Enterprise Linux 3.3"
    oses << "Red Hat Enterprise Linux 3.4"
    oses << "Red Hat Enterprise Linux 3.5"
    oses << "Red Hat Enterprise Linux 3.6"
    oses << "Red Hat Enterprise Linux 3.7"
    oses << "Red Hat Enterprise Linux 3.8"
    oses << "Red Hat Enterprise Linux 3.9"
    oses << "-"
    oses << "Red Hat Enterprise Linux 4"
    oses << "Red Hat Enterprise Linux 4.1"
    oses << "Red Hat Enterprise Linux 4.2"
    oses << "Red Hat Enterprise Linux 4.3"
    oses << "Red Hat Enterprise Linux 4.4"
    oses << "Red Hat Enterprise Linux 4.5"
    oses << "Red Hat Enterprise Linux 4.6"
    oses << "Red Hat Enterprise Linux 4.7"
    oses << "Red Hat Enterprise Linux 4.8"
    oses << "Red Hat Enterprise Linux 4.9"
    oses << "-"
    oses << "Red Hat Enterprise Linux 5"
    oses << "Red Hat Enterprise Linux 5.1"
    oses << "Red Hat Enterprise Linux 5.2"
    oses << "Red Hat Enterprise Linux 5.3"
    oses << "Red Hat Enterprise Linux 5.4"
    oses << "Red Hat Enterprise Linux 5.5"
    oses << "Red Hat Enterprise Linux 5.6"
    oses << "Red Hat Enterprise Linux 5.7"
    oses << "Red Hat Enterprise Linux 5.8"
    oses << "Red Hat Enterprise Linux 5.9"
    oses << "Red Hat Enterprise Linux 5.10"
    oses << "-"
    oses << "Red Hat Enterprise Linux 6"
    oses << "Red Hat Enterprise Linux 6.1"
    oses << "Red Hat Enterprise Linux 6.2"
    oses << "Red Hat Enterprise Linux 6.3"
    oses << "Red Hat Enterprise Linux 6.4"
    oses << "Red Hat Enterprise Linux 6.5"
    oses << "-"
    oses << "Red Hat Enterprise Linux 7"
    oses << "-"
    oses << "Windows 95"
    oses << "Windows 98"
    oses << "Windows 98 SE"
    oses << "Windows ME"
    oses << "-"
    oses << "Windows NT 4.0 Workstation"
    oses << "Windows NT 4.0 Embedded"
    oses << "-"
    oses << "Windows 2000 Professional"
    oses << "-"
    oses << "Windows XP Starter"
    oses << "Windows XP Home"
    oses << "Windows XP Media Center"
    oses << "Windows XP Tablet PC"
    oses << "Windows XP Professional"
    oses << "Windows XP Professional x64"
    oses << "Windows XP 64 bit (Itanium)"
    oses << "-"
    oses << "Windows Vista Starter"
    oses << "Windows Vista Home Basic"
    oses << "Windows Vista Home Basic N"
    oses << "Windows Vista Home Premium"
    oses << "Windows Vista Business"
    oses << "Windows Vista Business N"
    oses << "Windows Vista Enterprise"
    oses << "Windows Vista Ultimate"
    oses << "-"
    oses << "Windows 7 Starter"
    oses << "Windows 7 Home Basic"
    oses << "Windows 7 Home Premium"
    oses << "Windows 7 Professional"
    oses << "Windows 7 Ultimate"
    oses << "Windows 7 Enterprise"
    oses << "-"
    oses << "Windows NT 4.0 Server"
    oses << "Windows NT 4.0 Server, Enterprise"
    oses << "Windows NT 4.0 Server, Terminal Server"
    oses << "-"
    oses << "Windows 2000 Server"
    oses << "Windows 2000 Advanced Server"
    oses << "Windows 2000 Datacenter Server"
    oses << "-"
    oses << "Windows Server 2003 Standard"
    oses << "Windows Server 2003 Web"
    oses << "Windows Server 2003 Enterprise"
    oses << "Windows Server 2003 Datacenter"
    oses << "-"
    oses << "Windows Compute Cluster Server 2003"
    oses << "-"
    oses << "Windows Storage Server 2003"
    oses << "Windows Storage Server 2003 R2"
    oses << "Windows Storage Server 2008"
    oses << "Windows Storage Server 2008 R2"
    oses << "Windows Storage Server 2012"
    oses << "Windows Storage Server 2012 R2"
    oses << "-"
    oses << "Windows Home Server"
    oses << "Windows Home Server 2011"
    oses << "-"
    oses << "Windows Server 2008 Foundation"
    oses << "Windows Server 2008 Standard"
    oses << "Windows Server 2008 Web"
    oses << "Windows Server 2008 HPC"
    oses << "Windows Server 2008 Enterprise"
    oses << "Windows Server 2008 Datacenter"
    oses << "Windows Server 2008 Itanium"
    oses << "-"
    oses << "Windows Small Business Server 2008"
    oses << "Windows Essential Business Server 2008"
    oses << "-"
    oses << "Windows Server 2008 R2 Foundation"
    oses << "Windows Server 2008 R2 Standard"
    oses << "Windows Server 2008 R2 Web"
    oses << "Windows Server 2008 R2 HPC"
    oses << "Windows Server 2008 R2 Enterprise"
    oses << "Windows Server 2008 R2 Datacenter"
    oses << "Windows Server 2008 R2 Itanium"
    oses << "-"
    oses << "Windows Server 2012 Foundation"
    oses << "Windows Server 2012 Essentials"
    oses << "Windows Server 2012 Standard"
    oses << "Windows Server 2012 Datacenter"
    oses << "-"
    oses << "Windows Server 2012 R2 Essentials"
    oses << "Windows Server 2012 R2 Standard"
    oses << "Windows Server 2012 R2 Datacenter"
    return oses
  end


  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end
end
