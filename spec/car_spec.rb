# require_relative 'spec_helper'
# require 'active_record'
# require_relative '..db/migrate/20200323190437_create_cars'
# require_relative '../lib/car.rb'

require_relative '../config/environment.rb'


describe "Car" do
    let (:ford) { Car.new(make: "Ford") }

    it "has data attributes" do
      expect(ford.make).to eq("Ford")
        # test_car = Car.create(:id => 100, :make => "Mazda", :model => "6", :year => 2020, :price_per_day => 60.99, :license_plate => "TESTCAR", :city_id => 1)
        # expect(car.make).to eq("Ford")
  end 

end