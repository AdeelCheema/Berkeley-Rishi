require "rails_helper"
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

describe Ward do
    before(:each) do
        DatabaseCleaner.clean
        @ward_1 = FactoryGirl.create(:ward)
        @coordinate_1 = FactoryGirl.create(:coordinate)
        @coordinate_2 = FactoryGirl.create(:coordinate, :lat => 30.987524, :lng => 77.313168)
        @coordinate_3 = FactoryGirl.create(:coordinate, :lat => 30.806854, :lng => 77.066531)
        @coordinate_4 = FactoryGirl.create(:coordinate, :lat => 30.577421, :lng => 77.504928)
        @ward_1.coordinates << [@coordinate_1, @coordinate_2, @coordinate_3, @coordinate_4]
    end
    describe ".build_markers" do
        context "with 1 ward" do
            it "contains 4 markers" do
                marker_hash = Ward.build_markers
                marker_hash_size = marker_hash.size
                coord_size = Coordinate.all.size
                expect(marker_hash_size).to eql(coord_size)
            end
        end
    end
    describe ".build_ward_overlay" do
        context "region contains 1 ward" do
            it "contains 1 ward" do
                regions = Ward.build_ward_overlay
                region_size = regions.size
                num_wards = Ward.all.size
                expect(region_size).to eql(num_wards)
            end
        end
    end
end