# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Subscription < ActiveRecord::Base
  belongs_to :organization

  attr_accessor :stripe_card_token

  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }

  validates :organization, presence: true

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: self.organization_id,  plan: "Bang", card: self.stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end
end
