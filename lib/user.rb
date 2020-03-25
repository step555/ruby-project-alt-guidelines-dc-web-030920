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


    def create_reservation(carid, pd, dd, trip_d)
        res = Reservation.create(user_id: self.id, car_id: carid, pickup_date: pd, dropoff_date: dd, trip_duration: trip_d, paid: false) 
    end


  

    #retireves a a user's unpaid resercations
    def unpaid_reservations
        self.reservations.select do |r|
            !r.paid 
        end
    end

    def change_all_reservations_to_paid
        self.reservations.each do |r|
            r.paid = true
            r.save
        end
    end

    def display_unpaid(unpaid)
        puts "#{self.username.upcase} UNPAID RESERVATIONS"
        count = 1 
        total = 0 
            unpaid.each do |r|
                car = Car.find_by(id:r.car_id)
                total += (car.price_per_day*r.trip_duration.to_f).round(2)
                puts "~~~~ RESERVATION #{count} ~~~~"
                    display_a_reservation(r)
                count += 1 
            end
        puts "Would you like to pay your total balance of $#{total.round(2)}? 'Y' or 'N'"
            answer = input_yes_or_no
            if answer == "Y" 
                change_all_reservations_to_paid
                puts "Payment confirmed! Thank you for your business!"
            else 
                puts  "Please pay us sometime soon!"
            end
    end

    def make_payment
     unpaid = self.unpaid_reservations
        if unpaid.length > 0 
            display_unpaid(unpaid)
        else 
            puts "You don't owe us any money!"
        end
    end
end