class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_cache_headers
  include SessionsHelper

  private

  # to prevent caching of page by browsers
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
