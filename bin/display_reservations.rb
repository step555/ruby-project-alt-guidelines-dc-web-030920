def display_reservations(user_name)
    user = User.find_by(username: user_name)
    user.reservations.each do |r|
        puts "***************************"
        car = Car.find_by(id: r.car_id)
        puts "Pickup Date: #{r.pickup_date}"        
        puts "Dropoff date: #{r.dropoff_date}"
        puts "Trip duration: #{r.trip_duration}"
        puts "Car: #{car.make} #{car.model} #{car.year}...or similiar"
        puts "License plate: #{car.license_plate}"
        puts "Price per Day: $#{car.price_per_day}"
        total_price = car.price_per_day*r.trip_duration.to_f #add calculation for trip_duration
        puts "Total Price: $#{total_price}"
    end
    puts 'If you would like to return to the main menu enter "Y". If you would like to quit, enter "N"'
    answer = user_input
    if answer == "Y"
        main_menu(user_name)
    elsif answer == "N"
        goodbye
    end

end