# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Update < ActiveRecord::Base
  # relationships
  has_many :installations

  # validations
  validates :title, :platform, presence: true
  validates :role, :platform => { :in => ["Windows"] }
end
