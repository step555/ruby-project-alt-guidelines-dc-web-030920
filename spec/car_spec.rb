
require_relative "../config/environment.rb"

describe "Car" do 
    let (:ford) { Car.new(make: "Ford", model: "Fusion", city_id: 1)}

    it "has data attributes" do 
        expect(ford.make).to eq("Ford")
        expect(ford.model).to eq("Fusion")
        expect(ford.city_id).to eq(1)
    end
 
    it "belongs to a city" do
        expect(ford.city.name).to eq("Washington, DC")
    end

    it "can have many reservations" do
         expect(ford.reservations.length).to eq(0) 
    end


end