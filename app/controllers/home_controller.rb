class HomeController < ApplicationController
  def index
    @api_key = ENV['google_api_key']
    @wards = Ward.all
    @coordinates = Coordinate.all
    @marker_hash = Ward.build_markers
    @regions = Ward.build_ward_overlay
  end
  
  def about
  end
  
  def authen
    session[:return_to] = request.referer
    render :layout => 'authorize'
  end
  
  def back
    if session[:return_to]
      redirect_to session[:return_to]
    else
      redirect_to root_path
    end
  end
end
