class User < ActiveRecord::Base
    has_many :reservations
    has_many :cars, through: :reservations
    
# This displays one reservation - It needs to be moved to CLI .. but it works here for now. 
    def display_a_reservation(r)  
        car = Car.find_by(id: r.car_id)
        puts "Pickup Date: #{r.pickup_date}"        
        puts "Dropoff date: #{r.dropoff_date}"
        puts "Trip duration: #{r.trip_duration}"
        puts "Car: #{car.make} #{car.model} #{car.year}...or similiar"
        puts "License plate: #{car.license_plate}"
        puts "Price per Day: $#{car.price_per_day}"
        total_price = (car.price_per_day*r.trip_duration.to_f).round(2)
        puts "Total Price: $#{total_price}"
        if r.paid
            puts "PAID"
        else
            puts "You owe #{total_price}"
        end
    end

#displays the reservations for the user instance - It needs to be moved to CLI .. but it works here for now. 
    def display_reservations
        reload
        res = self.reservations
        if res.length == 0 
            puts "You don't have any reservations at this time."
        else
            count = 1 
            puts "#{self.username.upcase}'S CONFIRMED RESERVATIONS"
            res.each do |r|
                puts "~~~~~RESERVATION - #{count}~~~~~"
                display_a_reservation(r)
                count += 1
            end
        end
    end

#creates a new reservation and saves it to the database ** This should stay in User class 
    def create_reservation(carid, pd, dd, trip_d)
        res = Reservation.create(user_id: self.id, car_id: carid, pickup_date: pd, dropoff_date: dd, trip_duration: trip_d, paid: false) 
    end

#changes all reservations to paid ** This should stay in User class 
def change_all_reservations_to_paid
    self.reservations.each do |r|
        r.paid = true
        r.save
    end
end
  
end