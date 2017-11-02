class Ward < ActiveRecord::Base
    has_many :committees
    has_many :coordinates


    # def self.build_markers
    #
    #   coordinates = Coordinate.all
    #   marker_hash = Gmaps4rails.build_markers(coordinates) do |coordinate, marker|
    #     marker.lat coordinate.lat
    #     marker.lng coordinate.lng
    #     marker.infowindow "contentString"
    #   end
    #   return marker_hash
    # end

    def self.build_ward_overlay()
      regions = []
      wards = Ward.all
      wards.each do |ward|
        ward_coordinates = ward.coordinates
        @ward_marker_hash = Gmaps4rails.build_markers(ward_coordinates) do |coordinate, marker|
          marker.lat coordinate.lat
          marker.lng coordinate.lng
        end
        regions.push(@ward_marker_hash)
      end
      return regions
    end
    
end