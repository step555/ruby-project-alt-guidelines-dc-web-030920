class Cli
    attr_accessor :user 

    #outputs an image of a car
    def car_image
        puts <<-'E0F'
        ____----------- _____
        \~~~~~~~~~~/~_--~~~------~~~~~     \
         `---`\  _-~      |                   \
           _-~  <_         |                     \[]
         / ___     ~~--[""] |      ________-------'_
        > /~` \    |-.   `\~~.~~~~~                _ ~ - _
         ~|  ||\%  |       |    ~  ._                ~ _   ~ ._
           `_//|_%  \      |          ~  .              ~-_   /\
                  `--__     |    _-____  /\               ~-_ \/.
                       ~--_ /  ,/ -~-_ \ \/          _______---~/
                           ~~-/._<   \ \`~~~~~~~~~~~~~     ##--~/
                                 \    ) |`------##---~~~~-~  ) )
                                  ~-_/_/                  ~~ ~~
        E0F
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

    def main_menu
        welcome_user 
        #selecting number option from menu 
        menu_selection = input_text
            if menu_selection == "1"
                # all the methods to let someone book a car
                # make_reservation(user)
            elsif menu_selection == "2"
                 self.user.display_reservations
                 return_main_menu
            elsif menu_selection == "3"
                # make_payment(user)
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


# ef gets_car 
#     puts "Please enter the number for the car would you like to book"
#     Car.all.each do |c|
#         puts "#{c.id}. #{c.make} #{c.model} #{c.year} $#{c.price_per_day} per day."
#     end
#     car_input#not_yes_or_no
# end

# def gets_pd
#     puts "Select your pickup date using a YYYY-MM-DD HH:MM:SS"
#     not_yes_or_no
# end

# def gets_dd
#     puts "Select your dropoff date YYYY-MM-DD HH:MM:00"
#     not_yes_or_no
# end


# def create_reservation(input_u, input_c, input_pd, input_dd, trip_d)
#     res = Reservation.create(user_id: input_u, car_id: input_c, pickup_date: input_pd, dropoff_date: input_dd, trip_duration: trip_d, paid: false) 
#     res
# end

#     #once username obtained
#     #select car
#     #select dates for car #ensure pickup date is earlier than dropoff date

# def confirm_reservation(user, input_c, input_pd, input_dd, trip_d)
#     car = Car.find_by(id:input_c)
#     total_price = (trip_d*car.price_per_day).round(2)
#     puts "Please go over your reservation and make changes if necessary"
#     puts "Customer: #{user.username}"
#     puts "Car: #{car.make} #{car.model} #{car.year}...or similar"
#     puts "Pickup Date: #{input_pd}"
#     puts "Dropoff Date: #{input_dd}"
#     puts "Trip Duration: #{trip_d} days"
#     puts "Price per day: $#{car.price_per_day}"
#     puts "Total Price: $#{total_price}"
#     puts "To confirm your reservation enter Y, To cancel and return to the main menu enter N"
#     user_input
# end

# def make_reservation(user)
#     # user = User.find_by(username: user_name)
#     if user.age < 25
#        puts "We're sorry, you're too young to rent a car!"
#     else
#         input_u = user.id
#         input_c = gets_car
#         input_pd = gets_pd
#         input_dd = gets_dd
#         #maybe create an error message if the dates are invalid
#         trip_d = (input_dd.to_datetime - input_pd.to_datetime).to_f.ceil
#         user_confirmation = confirm_reservation(user, input_c, input_pd, input_dd, trip_d)
#             if user_confirmation == "Y" 
#                 create_reservation(input_u, input_c, input_pd, input_dd, trip_d)
#                 #lets change this to display reservation that was just created and 
#                 #then ask if they would like to review all reservations or return to the main menu? 
#                 #theres an issue with the most recent addition being included with the display reservations below. 
                
#                 display_reservations(user)
#             end
#     end
#     return_main_menu(user)
# end
#     #message invalid entry + return to whatever it returns to 