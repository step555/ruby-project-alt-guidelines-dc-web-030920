require_relative '../config/environment'
require_relative '../bin/book_reservation'
require_relative '../bin/display_reservations'

puts "hello world"

def greet
    puts "Hello! Welcome to the coolest car rental app ever!"
    puts "Please enter your username: " 
end

def welcome_user(user_name)
    puts "Welcome #{user_name}. What would you like to do today?"
    puts "1. Book a new reservation"
    puts "2. Review Reservations" #current reservation & reservation history
    # puts "3. Make a payment"
end

def user_input
    gets.strip
end


def run 
    greet 
    user_name = user_input#.downcase
end



def main_menu(user_name)
    welcome_user(user_name)
    #selecting number option from menu 
    menu_selection = user_input
    if menu_selection == "1"
        # all the methods to let someone book a car
        make_reservation(user_name)
    elsif menu_selection == "2"
        display_reservations(user_name)
    end
end

username = run
main_menu(username)