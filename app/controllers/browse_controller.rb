# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class BrowseController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:home, :download, :pricing, :buy, :features, :roadmap]

  # GET /browse/home
  def home
  end

  # GET /browse/download
  def download
    @highlight = "download"
  end

  # GET /browse/pricing
  def pricing
    @highlight = "pricing"
  end

  # GET /browse/sign_up
  def buy
    @highlight = "pricing"

    # Set session variable
    if params.has_key?(:plan)
      plan = { :name => params[:plan]  }
      case params[:plan]
      when "Brook"
        plan[:price_cents] = 19*100
        plan[:devices] = 5
        plan[:assisted] = 1
      when "Stream"
        plan[:price_cents] = 89*100
        plan[:devices] = 25
        plan[:assisted] = 5
      when "Creek"
        plan[:price_cents] = 299*100
        plan[:devices] = 100
        plan[:assisted] = 20
      when "River"
        plan[:price_cents] = 599*100
        plan[:devices] = 500
        plan[:assisted] = 50
      end
      session[:plan] = plan
    end
  end

  # GET /browse/features
  def features
    @highlight = "features"
  end

  # GET /browse/roadmap
  def roadmap
    @highlight = "features"
  end
end
