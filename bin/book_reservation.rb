#what do we need to create a res

def date_input


end

    
# def user_input
#     input = gets.strip.upcase
#     if input == "N"
#         return input
#     elsif input == "Y"
#         return input
#     else
#         puts "Invalid entry, please try again."
#         user_input
#     end
# end

def gets_car 
    puts "Please enter the number for the car would you like to book"
    Car.all.each do |c|
        puts "#{c.id}. #{c.make} #{c.model} #{c.year} $#{c.price_per_day} per day."
    end
    car_input#not_yes_or_no
end

def gets_pd
    puts "Select your pickup date using a YYYY-MM-DD HH:MM:SS"
    not_yes_or_no
end

def gets_dd
    puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
    not_yes_or_no
end


def create_reservation(input_u, input_c, input_pd, input_dd, trip_d)
    res = Reservation.create(user_id: input_u, car_id: input_c, pickup_date: input_pd, dropoff_date: input_dd, trip_duration: trip_d, paid: false) 
    res
end

    #once username obtained
    #select car
    #select dates for car #ensure pickup date is earlier than dropoff date

def confirm_reservation(user, input_c, input_pd, input_dd, trip_d)
    car = Car.find_by(id:input_c)
    total_price = (trip_d*car.price_per_day).round(2)
    puts "Please go over your reservation and make changes if necessary"
    puts "Customer: #{user.username}"
    puts "Car: #{car.make} #{car.model} #{car.year}...or similar"
    puts "Pickup Date: #{input_pd}"
    puts "Dropoff Date: #{input_dd}"
    puts "Trip Duration: #{trip_d} days"
    puts "Price per day: $#{car.price_per_day}"
    puts "Total Price: $#{total_price}"
    puts "To confirm your reservation enter Y, To cancel and return to the main menu enter N"
    user_input
end

def make_reservation(user)
    # user = User.find_by(username: user_name)
    if user.age < 25
       puts "We're sorry, you're too young to rent a car!"
    else
        input_u = user.id
        input_c = gets_car
        input_pd = gets_pd
        input_dd = gets_dd
        #maybe create an error message if the dates are invalid
        trip_d = (input_dd.to_datetime - input_pd.to_datetime).to_f.ceil
        user_confirmation = confirm_reservation(user, input_c, input_pd, input_dd, trip_d)
            if user_confirmation == "Y" 
                create_reservation(input_u, input_c, input_pd, input_dd, trip_d)
                #lets change this to display reservation that was just created and 
                #then ask if they would like to review all reservations or return to the main menu? 
                #theres an issue with the most recent addition being included with the display reservations below. 
                display_reservations(user)
            end
    end
    return_main_menu(user)
end
    #message invalid entry + return to whatever it returns to 