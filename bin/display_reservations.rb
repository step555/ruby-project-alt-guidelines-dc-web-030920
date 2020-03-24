def display_a_reservation(r, count)
        puts "~~~~~RESERVATION - #{count}~~~~~"
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

def display_reservations(user)
    # user = User.find_by(username: user_name)
    res = user.reservations
    if res.length == 0 
       puts "You don't have any reservations at this time."
    else
        count = 1 
        puts "#{user.username.upcase}'S CONFIRMED RESERVATIONS"
        res.each do |r|
            display_a_reservation(r, count)
            count += 1
        end
    end
    return_main_menu(user)
end