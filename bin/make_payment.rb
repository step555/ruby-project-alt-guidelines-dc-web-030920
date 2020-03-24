
def make_payment(user)
    puts "#{user.username.upcase} UNPAID RESERVATIONS"
    unpaid_reservations = user.reservations.select do |r|
        !r.paid 
    end
    count = 1 
    total = 0 
    unpaid_reservations.each do |r|
        car = Car.find_by(id:r.car_id)
        total_price = car.price_per_day*r.trip_duration.to_f 
        total += total_price
        puts "RESERVATION - #{count}"
        puts "Pickup Date: #{r.pickup_date}"        
        puts "Dropoff date: #{r.dropoff_date}"
        puts "Trip duration: #{r.trip_duration}"
        puts "Car: #{car.make} #{car.model} #{car.year}...or similiar"
        puts "License plate: #{car.license_plate}"
        puts "Price per Day: $#{car.price_per_day}"
        puts "Total Price: $#{total_price}"
        if r.paid
            puts "PAID"
        else
            puts "You owe #{total_price}"
        end
        count += 1
    end
    puts "Would you like to pay your total balance of $#{total}? 'Y' or 'N'"

end