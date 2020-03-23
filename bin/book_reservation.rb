#what do we need to create a res

def gets_car 
    puts "Please enter the number for the car would you like to book"
    Car.all.each do |c|
        puts "#{c.id}. #{c.make} #{c.model} #{c.year}"
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


def create_reservation(input_u, input_c, input_pd, input_dd, input_td)
    res = Reservation.Create(user_id: input_u, car_id: input_c, pickup_date: input_pd, dropoff_date: input_dd, trip_duration: input_td)
    res
end

#once username obtained
    #select car
    #select dates for car #ensure pickup date is earlier than dropoff date


def make_reservation(user_name)
    user = User.find_by(username: user_name)
    input_u = user.id
    input_c = gets_car
    input_pd = gets_pd
    input_dd = gets_dd
    binding.pry
    
end
    