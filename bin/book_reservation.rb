#what do we need to create a res

def gets_car 
    puts "Please enter the number for the car would you like to book"
    Car.all.each do |c|
        puts "#{c.id}. #{c.make} #{c.model} #{c.year} $#{c.price_per_day} per day."
    end
    user_input
end

def gets_pd
    puts "Select your pickup date using a YYYY-MM-DD HH:MM:SS"
    user_input
end

def gets_dd
    puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
    user_input
end


def create_reservation(input_u, input_c, input_pd, input_dd)
    res = Reservation.create(user_id: input_u, car_id: input_c, pickup_date: input_pd, dropoff_date: input_dd) 
    res
end

#once username obtained
    #select car
    #select dates for car #ensure pickup date is earlier than dropoff date

def confirm_reservation(user_name, input_c, input_pd, input_dd)
    car = Car.find_by(id:input_c)
    # user = User.find_find(username: user_name)
    puts "Please go over your reservation and make changes if necessary"
    puts "Customer: #{user_name}"
    puts "Car: #{car.make} #{car.model} #{car.year}...or similar"
    puts "Pickup Date: #{input_pd}"
    puts "Dropoff Date: #{input_dd}"
    puts "Price per day: $#{car.price_per_day}"
    puts "To confirm your reservation enter Y, To cancel and return to the main menu enter N"
    user_input
end

def make_reservation(user_name)
    user = User.find_by(username: user_name)
    input_u = user.id
    input_c = gets_car
    input_pd = gets_pd
    input_dd = gets_dd
    user_confirmation = confirm_reservation(user, input_c, input_pd, input_dd)
    # add functionality to allow customer to put "y"
        if user_confirmation == "Y" 
            create_reservation(input_u, input_c, input_pd, input_dd)
            #lets change this to display reservation that was just created and 
            #then ask if they would like to review all reservations or return to the main menu? 
            display_reservations(user_name)
        elsif user_confirmation == "N"
            main_menu(user_name)
        end
end
    #message invalid entry + return to whatever it returns to 