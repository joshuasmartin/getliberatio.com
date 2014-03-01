# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Update < ActiveRecord::Base
  # relationships
  belongs_to :node
  belongs_to :organization

  # validations
  validates :node, :organization, :platform, :title, presence: true
  validates :platform, inclusion: { in: ["Windows"] }
end
