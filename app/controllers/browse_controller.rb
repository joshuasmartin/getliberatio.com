# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class BrowseController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:home, :pricing]

  # GET /browse/home
  def home
  end

  # GET /browse/dashboard
  def dashboard
  end
  
end
