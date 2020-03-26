class Car < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations
    belongs_to :city



    def self.city_cars(city_id)
     Car.all.select do |c|
            c.city_id == city_id
        end
    end

    
end