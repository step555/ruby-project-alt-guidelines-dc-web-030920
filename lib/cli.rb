class Cli < ActiveRecord::Base
    attr_accessor :user 
    
    #displays a welcome message 
    def welcome
        car_image
        # car_sound
        puts "WELCOME TO THE SUPER COOL CAR RENTAL APP!!! "
    end

    def car_sound
        pid = fork{exec 'afplay', "lib/BMW+DRIVEBY.mp3"}
    end

    #outputs an image of a car
    def car_image
        # puts <<-'EOF'
        # ____----------- _____
        # \~~~~~~~~~~/~_--~~~------~~~~~     \
        #  `---`\  _-~      |                   \
        #    _-~  <_         |                     \[]
        #  / ___     ~~--[""] |      ________-------'_
        # > /~` \    |-.   `\~~.~~~~~                _ ~ - _
        #  ~|  ||\%  |       |    ~  ._                ~ _   ~ ._
        #    `_//|_%  \      |          ~  .              ~-_   /\
        #           `--__     |    _-____  /\               ~-_ \/.
        #                ~--_ /  ,/ -~-_ \ \/          _______---~/
        #                    ~~-/._<   \ \`~~~~~~~~~~~~~     ##--~/
        #                          \    ) |`------##---~~~~-~  ) )
        #                           ~-_/_/                  ~~ ~~
        # EOF
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
                i_age = new_user_age
                user = User.create(username: username, age: i_age)
                self.user = user
                main_menu
            end
    end

    def new_user_age
        puts "Please enter your age:"
        i_age = input_text.to_i
        if i_age <= 0
            invalid_entry_message
            new_user_age
        end
        return i_age
    end
    
    #allows the user to login, saves that user to the instance of CLI...or continues through new user if user does not exist
    def login
        puts "Please login with your username:"
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

    #displays menu options with the cli's user's username 
    def welcome_user
        puts "Welcome #{self.user.username}. What would you like to do today?"
        puts "1. Book a new reservation"
        puts "2. Review Reservations"
        puts "3. Cancel Reservations"
        puts "4. Make Payment"
        puts "5. Quit"
    end

    #user views the mainmenu and makes a selection 
    def main_menu
        welcome_user 
        #selecting number option from menu 
        menu_selection = input_text
            if menu_selection == "1"
                book_reservation
                # return_main_menu
                main_menu
            elsif menu_selection == "2"
                display_reservations
                    return_main_menu
            elsif menu_selection == "3"
                cancel_reservations
            elsif menu_selection == "4"
                make_payment
                    return_main_menu
            elsif menu_selection == "5"
                goodbye
            else
                invalid_entry_message
                main_menu
            end
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
    
    def select_city 
        puts "Where would you like to rent your car?"
        City.all.each do |c|
            puts "#{c.id}. #{c.name}"
        end
        input_text
    end 
    def select_car(city_id)
        puts "Please enter the number for the car would you like to book"
        city_cars = Car.all.select {|c| c.city_id == city_id.to_i}
        city_cars.each do |c| 
            puts "#{c.id}.#{c.make} #{c.model} #{c.year}...or similar $#{c.price_per_day} per day."
        end
        car_input
    end

    # def select_date
    #     date = gets.strip
    #     begin
    #         date = date.to_datetime
    #     rescue
    #         puts "Invalid entry, please select your date in this format YYYY-MM-DD"
    #         select_date
    #     end
    #     return date
    # end


    #does not include error messages for dates. 
    # def book_reservation_old_version
    #     if self.user.age < 25
    #         puts "I'm sorry! You're too young to rent a car!"
    #     else
    #         puts "Please enter the number for the car would you like to book"
    #         Car.display_cars
    #         carid = car_input
    #         puts "Select your pickup date YYYY-MM-DD HH:MM:00"
    #         pd = input_text
    #         puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
    #         dd = input_text
    #         trip_d = (dd.to_datetime - pd.to_datetime).to_f.ceil
    #         confirm_reservation(carid, pd, dd, trip_d)
    #         response = input_yes_or_no
    #         if response == 'Y'
    #             self.user.create_reservation(carid,pd,dd,trip_d)
    #             display_reservations
    #         end
    #     end
    # end


    # def book_reservation_city_and_carid_first#WORKS
    #     if self.user.age < 25
    #         puts "I'm sorry! You're too young to rent a car!"
    #     else
    #         city_id = select_city
    #         çarid = select_car(city_id)
    #     end
    #     def book_reservation_dates
    #         begin
    #             puts "Select your pickup date YYYY-MM-DD HH:MM:00" #1-1-1 is valid here. should not be valid...
    #             pd = input_text
    #             puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
    #             dd = input_text
    #             trip_d = (dd.to_datetime - pd.to_datetime).to_f.ceil
    #             rescue #rescue NameError, ArgumentError #these two need to be tested later
    #             puts "Invalid entry, please try again!"
    #             book_reservation_dates
    #             else
    #             confirm_reservation(çarid, pd, dd, trip_d)
    #             end
    #         response = input_yes_or_no
    #         if response == 'Y'
    #             self.user.create_reservation(çarid,pd,dd,trip_d)
    #             display_reservations
    #         end
    #     end
    #     book_reservation_dates
    # end

    def book_reservation #WORKS
        if self.user.age < 25
            puts "I'm sorry! You're too young to rent a car!"
        else
            puts "Select your pickup date YYYY-MM-DD HH:MM:00" #1-1-1 is valid here. should not be valid...
            pd = input_text
            puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
            dd = input_text
            begin
                trip_d = (dd.to_datetime - pd.to_datetime).to_f.ceil
                if trip_d < 0
                    puts "Your dropoff date cannot be before your pickup date. Please re-select your dates"
                    return book_reservation
                end
            rescue #rescue NameError, ArgumentError #these two need to be tested later
                invalid_entry_message
                return book_reservation
            else
                city_id = select_city
                carid = select_car(city_id)
                confirm_reservation(carid, pd, dd, trip_d)
                end
            response = input_yes_or_no
            if response == 'Y'
                self.user.create_reservation(carid,pd,dd,trip_d)
                display_reservations
            end
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

    def display_a_reservation(r)  
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

    # def display_reservations #why is this here? duplicate method?
    #     res = self.user.reservations.reload
    #     if res.length == 0 
    #         puts "You don't have any reservations at this time."
    #     else
    #         count = 1 
    #         puts ("#{self.user.username.upcase}'S CONFIRMED RESERVATIONS").colorize(:green)
    #         res.each do |r|
    #             puts ("~~~~~RESERVATION - #{count}~~~~~").colorize(:green)
    #             display_a_reservation(r)
    #             count += 1
    #         end
    #     end
    # end

    def display_reservations
        res = self.user.reservations.reload
        if res.length == 0 
            puts "You don't have any reservations at this time."
        else
            count = 1 
            puts ("#{self.user.username.upcase}'S CONFIRMED RESERVATIONS").colorize(:green)
            res.each do |r|
                puts ("~~~~~RESERVATION - #{count}~~~~~").colorize(:green)
                display_a_reservation(r)
                count += 1
            end
        end
    end

    def cancel_res(future_res)
        future_res.each do |r|
            puts "~~~RESERVATION ID: #{r.id}~~~~"
            display_a_reservation(r)
        end
        puts "Please enter the Reservation ID for the reservation you would like to cancel."
        input_text
    end

    def are_you_sure #all reservations can be cancelled. not only the one belonging to user
        msg = "ARE YOU SURE YOU WANT TO CANCEL YOUR RESERVATION? Input 'Y' or 'N'"
        puts ""
            3.times do 
                print "\r#{'  '*msg.size}"
                sleep 0.5
                print "\r#{ msg.colorize(:red)}"
                sleep 0.5
            end
        system `say #{msg}`
        puts ""
        input_yes_or_no
    end

    def final_cancel(r_id)
        Reservation.find_by(id: r_id).destroy
    end 

    def cancel_reservations
        #display all user's reservations with future date 
        #display with ID number
        #ask user to enter the id number for the reservation they would like to cancel. 
        future_res = self.user.reservations.reload.select {|r| r.pickup_date > DateTime.now}
        if future_res.length == 0 
            puts "You have no future reservations"
            return_main_menu
        else
            r_id = cancel_res(future_res)
            answer = are_you_sure
            if answer == 'Y'
                final_cancel(r_id)
                puts "Your reservation has been cancelled."
            end
        end
        return_main_menu
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
                    display_a_reservation(r)
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
    
    #outputs a goodbye message and exits the app 
    def goodbye
        puts "Goodbye!"
        # goodbye_car
        exit
    end
    
    #the user can only enter a Y or N 
    def input_yes_or_no
        input = gets.strip.upcase
        if input == "N"
            return input
        elsif input == "Y"
            return input
        else
            invalid_entry_message
            input_yes_or_no
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
            invalid_entry_message
            car_input
        else
            return input
        end
    end

    def invalid_entry_message
        puts "Invalid entry, please try again."
    end
    

    # def goodbye_car
    # puts <<-'EOF'
    #         ___
    #         _-_-  _/\______\\__
    #     _-_-__  / ,-. -|-  ,-.`-.
    #         _-_- `( o )----( o )-'
    #             `-'      `-'
    # EOF
    # sleep 0.5
    # puts <<-'EOF'
    #                         ___
    #                         _-_-  _/\______\\__
    #                     _-_-__  / ,-. -|-  ,-.`-.
    #                         _-_- `( o )----( o )-'
    #                             `-'      `-'
    # EOF
    # sleep 0.5
    # puts <<-'EOF'
    #                                                     ___
    #                                                     _-_-  _/\______\\__
    #                                                 _-_-__  / ,-. -|-  ,-.`-.
    #                                                     _-_- `( o )----( o )-'
    #                                                         `-'      `-'
    # EOF                                               
    # end
end


