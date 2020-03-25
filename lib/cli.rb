class Cli < ActiveRecord::Base
    attr_accessor :user 

    #outputs an image of a car
    def car_image
    #     puts <<-'E0F'
    #     ____----------- _____
    #     \~~~~~~~~~~/~_--~~~------~~~~~     \
    #      `---`\  _-~      |                   \
    #        _-~  <_         |                     \[]
    #      / ___     ~~--[""] |      ________-------'_
    #     > /~` \    |-.   `\~~.~~~~~                _ ~ - _
    #      ~|  ||\%  |       |    ~  ._                ~ _   ~ ._
    #        `_//|_%  \      |          ~  .              ~-_   /\
    #               `--__     |    _-____  /\               ~-_ \/.
    #                    ~--_ /  ,/ -~-_ \ \/          _______---~/
    #                        ~~-/._<   \ \`~~~~~~~~~~~~~     ##--~/
    #                              \    ) |`------##---~~~~-~  ) )
    #                               ~-_/_/                  ~~ ~~
    #     E0F
    end

    #the user can only enter a Y or N 
    def input_yes_or_no
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

    #the user is expected to enter text or number
    def input_text
        gets.strip
    end

     #retrieves a car input from the user
     def car_input
        input = gets.strip.to_i
        if input < 1 || input > Car.all.length
            puts "Invalid entry, please try again." 
            car_input
        else
            return input
        end
    end

    #out puts a goodbye message and exits the app 
    def goodbye
        puts "Goodbye!"
        car_image
        exit
    end

    #displays menu options with the cli's user's username 
    def welcome_user
        puts "Welcome #{self.user.username}. What would you like to do today?"
        puts "1. Book a new reservation"
        puts "2. Review Reservations"
        puts "3. Make Payment"
        puts "4. Quit"
    end

    def return_main_menu
        puts "Would you like to return to the main menu? 'Y' or 'N'"
        input = input_yes_or_no
        if input == "Y"
            main_menu
        else
            goodbye
        end
    end

    def confirm_reservation(carid, pd, dd, trip_d)
        car = Car.find_by(id:carid)
        total_price = (trip_d*car.price_per_day).round(2)
        puts "Please review your reservation"
        puts "Customer: #{self.user.username}"
        puts "Car: #{car.make} #{car.model} #{car.year}...or similar"
        puts "Pickup Date: #{pd}"
        puts "Dropoff Date: #{dd}"
        puts "Trip Duration: #{trip_d} days"
        puts "Price per day: $#{car.price_per_day}"
        puts "Total Price: $#{total_price}"
        puts "To confirm your reservation enter Y, To cancel and return to the main menu enter N"
    end

    def book_reservation 
        if self.user.age < 25
            puts "I'm sorry! You're too young to rent a car!"
        else
            puts "Please enter the number for the car would you like to book"
            Car.display_cars
            carid = car_input
            puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
            pd = input_text
            puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
            dd = input_text
            trip_d = (dd.to_datetime - pd.to_datetime).to_f.ceil
            confirm_reservation(carid, pd, dd, trip_d)
            response = input_yes_or_no
                if response == 'Y'
                    self.user.create_reservation(carid,pd,dd,trip_d)
                    self.user.display_reservations
                end
        end
    end

       #retireves a a user's unpaid resercations
    def unpaid_reservations
        self.user.reservations.select do |r|
            !r.paid 
        end
    end


    def display_unpaid(unpaid)
        puts "#{self.user.username.upcase} UNPAID RESERVATIONS"
        count = 1 
        total = 0 
            unpaid.each do |r|
                car = Car.find_by(id:r.car_id)
                total += (car.price_per_day*r.trip_duration.to_f).round(2)
                puts "~~~~ RESERVATION #{count} ~~~~"
                    self.user.display_a_reservation(r)
                count += 1 
            end
        puts "Would you like to pay your total balance of $#{total.round(2)}? 'Y' or 'N'"
            answer = input_yes_or_no
            if answer == "Y" 
                self.user.change_all_reservations_to_paid
                puts "Payment confirmed! Thank you for your business!"
            else 
                puts  "Please pay us sometime soon!"
            end
    end

    #called on by the main menu. calls on unpaid reservations and displays them through display_unpaid. 
    def make_payment
     unpaid = unpaid_reservations
        if unpaid.length > 0 
            display_unpaid(unpaid)
        else 
            puts "You don't owe us any money!"
        end
    end


    #user views the mainmenu and makes a selection 
    def main_menu
        welcome_user 
        #selecting number option from menu 
        menu_selection = input_text
            if menu_selection == "1"
                book_reservation
                return_main_menu
            elsif menu_selection == "2"
                self.user.display_reservations
                 return_main_menu
            elsif menu_selection == "3"
                make_payment
                 return_main_menu
            elsif menu_selection == "4"
                goodbye
            end
    end

    #creates a new user and saves that user to the cli instance 
    def new_user
        puts "Please enter a username:"
        username = input_text
        user_already_created = User.find_by(username: username)
            if user_already_created
                puts "I'm sorry, that username already exists"
                new_user
            else
                puts "Please enter your age:"
                i_age = input_text
                user = User.create(username: username, age: i_age)
                self.user = user
                main_menu
            end
    end
    
    #allows the user to login, saves that user to the instance of CLI...or continues through new user if user does not exist
    def login
        puts "Please login with your username:" #password later
        input = input_text
        user = User.find_by(username:input)
            if user 
                #an instance of user is saved to the cli instance
                self.user = user
                main_menu
            else 
                puts "No user found, would you like to create an account? 'Y' or 'N'"
                answer = input_yes_or_no
                if answer.upcase == "Y"
                    new_user
                elsif answer.upcase == "N"
                    goodbye
                end
            end
    end
    

    #displays a welcome message 
    def welcome
        car_image
        puts "WELCOME TO THE SUPER COOL CAR RENTAL APP!!! "
    end

    
end


