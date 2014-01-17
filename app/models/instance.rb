# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Instance < ActiveRecord::Base
  # relationships
  belongs_to :application
  belongs_to :node

  # validations
  validates :application, :node, presence: true
end
