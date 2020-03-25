
# def unpaid_reservations(user)
#     user.reservations.select do |r|
#         !r.paid 
#     end
# end


# def make_payment(user)
#     unpaid = unpaid_reservations(user)
#     if unpaid.length > 0 
#         puts "#{user.username.upcase} UNPAID RESERVATIONS"
#         count = 1 
#         total = 0 
#         unpaid.each do |r|
#             car = Car.find_by(id:r.car_id)
#             total += (car.price_per_day*r.trip_duration.to_f).round(2)
#             display_a_reservation(r,count)
#             count += 1 
#         end
#         puts "Would you like to pay your total balance of $#{total.round(2)}? 'Y' or 'N'"
#             answer = user_input
#             if answer == "Y" 
#                 unpaid.each do |r|
#                     r.paid = true
#                     # r.save
#                 end
#                 puts "Payment confirmed! Thank you for your business!"
#             else 
#                 puts  "Please pay us sometime soon!"
#             end
#     else 
#         puts "You don't owe us any money!"
#     end
#     return_main_menu(user)
# end