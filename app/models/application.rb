# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Application < ActiveRecord::Base
  # relationships
  has_many :instances, dependent: :destroy

  # validations
  validates :name, :publisher, :version, presence: true
end
