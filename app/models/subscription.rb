# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class Subscription < ActiveRecord::Base
  belongs_to :organization

  attr_accessible :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email,  plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end
end
