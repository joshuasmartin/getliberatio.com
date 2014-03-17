# -----------------------------------------------------------------------------
# This file is a part of Liberatio, a systems management Web application.
# The text in this file is subject to the terms defined in the LICENSE file.
#
# Copyright 2014, Joshua Shane Martin
# All Rights Reserved
# -----------------------------------------------------------------------------

class AutomaticUpdatesController < ApplicationController
  skip_before_filter :authenticate_user!

  def latest
    data = { windows: { version: "1.0.0.0", sha2sum: "the sum", url: "the url" } }
    respond_to do |format|
      format.json { render json: data }
    end
  end
end
