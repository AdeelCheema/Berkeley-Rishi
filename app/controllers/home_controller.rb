class HomeController < ApplicationController
  def index
    @api_key = ENV['google_api_key']
    @wards = Ward.all
    @coordinates = Coordinate.all
    @coordinates = Coordinate.all
    @marker_hash = Gmaps4rails.build_markers(@coordinates) do |coordinate, marker|
      marker.lat coordinate.lat
      marker.lng coordinate.lng
      marker.infowindow render_to_string(:partial => "/committees/popup_partial", :locals => { :object => coordinate})
    end
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
