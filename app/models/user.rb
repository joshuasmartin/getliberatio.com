# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class User < ActiveRecord::Base
  # accessors
  attr_accessor :organization_name

  # callbacks
  before_validation :set_defaults

  # relationships
  belongs_to :organization

  # security
  has_secure_password

  # validations
  validates :email_address, :name, :organization, :role, presence: true

  # convenience method to determine the role of a user
  def is?(role)
    self.role == role.downcase
  end

  # convenience method to determine the role of a user based on a given array of valid roles
  def among?(roles)
    downcased = roles.map(&:downcase)
    downcased.includes? self.role
  end

  private

    def set_defaults
      self.role = "standard" if self.role.blank?
      if self.organization.blank? && self.organization_name.present?
        self.organization = Organization.create(name: self.organization_name)
      end
    end

end
