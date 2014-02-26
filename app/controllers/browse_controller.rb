# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class BrowseController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:home, :pricing, :buy, :features, :roadmap]

  # GET /browse/home
  def home
  end

  # GET /browse/pricing
  def pricing
    @highlight = "pricing"
  end

  # GET /browse/sign_up
  def buy
    @highlight = "pricing"

    # Set the session
    session[:plan] = params[:plan] if params.has_key?(:plan)
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
