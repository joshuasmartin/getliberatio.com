# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Node < ActiveRecord::Base
  # callbacks
  before_validation :generate_uuid, :on => :create
  before_create :regenerate_token!

  # relationships
  belongs_to :organization
  has_many :commands, dependent: :destroy
  has_many :instances, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :processors, dependent: :destroy
  has_many :disks, dependent: :destroy
  has_many :updates, dependent: :destroy

  # validations
  validates :uuid, :organization, presence: true
  validates :role, :inclusion => {:in => ["Domain Controller", "Phone", "Router", "Server", "Tablet", "Workstation"]}, :if => Proc.new { |node| node.role.present? }
  # validates :operating_system, :inclusion => {:in => Node.operating_systems}

  # validate :validate_operating_system_in_operating_systems
  # def validate_operating_system_in_operating_systems
  #   errors.add(:base, "Operating system is not valid") if not Node.operating_systems.include?(self.operating_system)
  # end

  # Returns a newly created or updated node object for the given uuid. The
  # node will belong to the organization with the given registration code and
  # will have its communications token regenerated before being returned.
  def self.update_or_create_from_uuid(hsh = {})
    @organization = Organization.where(registration_code: hsh[:registration_code]).first
    @node = @organization.nodes.find_or_create_by(uuid: hsh[:uuid])
    @node.is_managed = true
    @node.regenerate_token!
    return @node
  end

  # Updates the node with the given id to the given status
  def self.update_status(hsh = {})
    @node = Node.find(hsh[:id])
    unless @node.blank?
      @node.update(status: hsh[:status])
    end
  end
  
  def inventory(inventory)
    self.update(inventory.except(:uuid, :applications, :memory, :processor, :disks, :updates).merge(:inventoried_at => Time.now))

    # applications
    self.instances.destroy_all
    inventory[:applications].each do |a|
      application = Application.find_or_create_by( name: a[:name],
                                                   publisher: a[:publisher],
                                                   version: a[:version] )

      self.instances << self.instances.new(application_id: application.id, organization_id: self.organization_id)
    end

    # memories
    self.memories.destroy_all
    inventory[:memory].each do |m|
      self.memories << self.memories.new( capacity: m[:capacity],
                                          form_factor: m[:form_factor],
                                          manufacturer: m[:manufacturer],
                                          memory_type: m[:memory_type],
                                          speed: m[:speed])
    end

    # processors
    self.processors.destroy_all
    inventory[:processor].each do |p|
      self.processors << self.processors.new( architecture: p[:architecture],
                                              name: p[:name],
                                              cores_count: p[:cores_count],
                                              speed: p[:speed])
    end

    # disks
    self.disks.destroy_all
    inventory[:disks].each do |d|
      self.disks << self.disks.new( disk_type: d[:disk_type],
                                    file_system: d[:file_system],
                                    free_bytes: d[:free_bytes],
                                    total_bytes: d[:total_bytes],
                                    volume_name: d[:volume_name])
    end

    # updates
    self.updates.destroy_all
    inventory[:updates].each do |u|
      self.updates << self.updates.new( title: u[:title],
                                        severity: u[:severity],
                                        support_url: u[:support_url],
                                        is_installed: u[:is_installed],
                                        organization_id: self.organization_id )
    end

    return self.save
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

  def online?
    response = Pusher.get("/channels/presence-cmd_#{self.uuid}/users")
    response[:users].any? { |u| u[:id] == self.id }
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

  # Generates and saves a new string of numbers as the token
  # for communication between the node and the Agent. Every communique
  # must contain the token for the communique to be authentic.
  def regenerate_token!
    self.token = SecureRandom.hex
    self.token_created_at = Time.now

    # Do not save for not-yet saved nodes.
    unless self.id.blank?
      self.save
    end
  end

  private
    def generate_uuid
      if self.uuid.blank?
        self.uuid = SecureRandom.uuid
      end
    end
end
