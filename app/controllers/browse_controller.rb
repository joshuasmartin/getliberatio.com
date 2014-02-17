# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class BrowseController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:home, :pricing, :features, :roadmap]

  # GET /browse/home
  def home
  end

  def pricing
    @highlight = "pricing"
  end

  def features
    @highlight = "features"
  end

  def roadmap
    @highlight = "features"
  end
  
end
