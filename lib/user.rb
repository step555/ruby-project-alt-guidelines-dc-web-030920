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
    end

    #retrieves a car input from the user
    def car_input
        input = gets.strip.to_i
        if input < 1 || input > Car.all.length
            puts "Invalid entry, please try again." 
            car_input
        else
            return input
        end
    end

    #the user is expected to enter text or number
    def input_text
        gets.strip
    end

    def input_yes_or_no
        input = gets.strip.upcase
        if input == "N"
            return input
        elsif input == "Y"
            return input
        else
            puts "Invalid entry, please try again."
            user_input
        end
    end

    def confirm_reservation(carid, pd, dd, trip_d)
        car = Car.find_by(id:carid)
        total_price = (trip_d*car.price_per_day).round(2)
        puts "Please reveiw your reservation"
        puts "Customer: #{self.username}"
        puts "Car: #{car.make} #{car.model} #{car.year}...or similar"
        puts "Pickup Date: #{pd}"
        puts "Dropoff Date: #{dd}"
        puts "Trip Duration: #{trip_d} days"
        puts "Price per day: $#{car.price_per_day}"
        puts "Total Price: $#{total_price}"
        puts "To confirm your reservation enter Y, To cancel and return to the main menu enter N"
    end

    def create_reservation(carid, pd, dd, trip_d)
        res = Reservation.create(user_id: self.id, car_id: carid, pickup_date: pd, dropoff_date: dd, trip_duration: trip_d, paid: false) 
    end


    def book_reservation 
        if self.age < 25
            puts "I'm sorry! You're too young to rent a car!"
        else
            puts "Please enter the number for the car would you like to book"
            Car.display_cars
            carid = car_input
            puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
            pd = input_text
            puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
            dd = input_text
            trip_d = (dd.to_datetime - pd.to_datetime).to_f.ceil
            confirm_reservation(carid, pd, dd, trip_d)
            response = input_yes_or_no
                if response == 'Y'
                    create_reservation(carid,pd,dd,trip_d)
                    self.display_reservations
                end
        end
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