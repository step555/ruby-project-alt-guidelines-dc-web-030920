require_relative '../config/environment'
require_relative '../bin/book_reservation'
require_relative '../bin/display_reservations'
require_relative '../bin/login'
require_relative '../bin/welcome_menu_goodbye'
require_relative '../bin/make_payment'
require 'date'

# puts "hello world"

def not_yes_or_no
    gets.strip
end

    
def user_input
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

def car_input
    input = gets.strip.to_i
    if input < 1 || input >= Car.all.length
        puts "Invalid entry, please try again." 
        car_input
    else
        return input
    end
end



run



