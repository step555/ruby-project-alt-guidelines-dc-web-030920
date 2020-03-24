def car_image
    puts  "  ______"
    puts "  /|_||_\`.__"
    puts '(   _    _ _\"'
    puts " =`-(_)--(_)-'"
  end

  def run 
    puts "Hello! Welcome to the coolest car rental app ever!" 
    car_image
    login
  end
  

  def welcome_user(user)
    puts "Welcome #{user.username}. What would you like to do today?"
    puts "1. Book a new reservation"
    puts "2. Review Reservations"
    puts "3. Make Payment"
    puts "4. Quit"
    #current reservation & reservation history
    # puts "3. Make a payment"
end

def main_menu(user)
    welcome_user(user)
    #selecting number option from menu 
    menu_selection = user_input
    if menu_selection == "1"
        # all the methods to let someone book a car
        make_reservation(user)
    elsif menu_selection == "2"
        display_reservations(user)
    elsif menu_selection == "3"
        make_payment(user)
    elsif menu_selection == "4"
        goodbye
    end
end
  
def goodbye
    puts "Goodbye!"
    car_image
    exit
end