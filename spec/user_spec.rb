require_relative "../config/environment.rb"

describe "User" do 
    let (:user) { User.new(username: "Lindsay", age: 28)}

    it "has data attributes" do 
        expect(user.username).to eq("Lindsay")
        expect(user.age).to eq(28)
    end

    it "can have many reservations" do
         expect(user.reservations.length).to eq(0) 
    end

end