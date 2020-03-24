def car_image
    puts  "  ______"
    puts "  /|_||_\`.__"
    puts '(   _    _ _\"'
    puts " =`-(_)--(_)-'"
  end

  def run 
    greet 
    user_name = user_input#.downcase
  end
  
  def greet
      puts "Hello! Welcome to the coolest car rental app ever!"
      puts "Please enter your username: " 
      car_image
  end

  def welcome_user(user_name)
    puts "Welcome #{user_name}. What would you like to do today?"
    puts "1. Book a new reservation"
    puts "2. Review Reservations"
    puts "3. Quit"
    #current reservation & reservation history
    # puts "3. Make a payment"
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
    elsif menu_selection == "3"
        goodbye
    end
end
  
def goodbye
    puts "Goodbye!"
    car_image
end