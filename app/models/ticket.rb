# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Ticket < ActiveRecord::Base
  # relationships
  belongs_to :organization
  belongs_to :user

  # validations
  validates :category, :description, :organization, :priority, :status, :user, presence: true

  def open?
    self.status == "Open"
  end

  def handling?
    self.status == "Handling"
  end

  def closed?
    self.status == "Closed"
  end
end
