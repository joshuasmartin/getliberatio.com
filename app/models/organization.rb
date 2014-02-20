# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Organization < ActiveRecord::Base
  # callbacks
  before_create :generate_registration_code

  # relationships
  has_many :nodes, dependent: :destroy
  has_many :instances, dependent: :destroy
  has_many :users, dependent: :destroy

  # validations
  validates :name, presence: true

  private
    def generate_registration_code
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      code = ''
      10.times { code << chars[rand(chars.size)] }

      self.registration_code = code
    end
end
