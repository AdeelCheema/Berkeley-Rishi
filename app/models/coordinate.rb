class Coordinate < ActiveRecord::Base
    belongs_to :wards
    has_many :coordinates
end
