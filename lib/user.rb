class User < ActiveRecord::Base
    has_many :reservations
    has_many :cars, through: :reservations
    
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

#displays the reservations for the user instance
    def display_reservations
        reload
        # user = User.find_by(username: user_name)
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
        # main_menu
    end







    

end