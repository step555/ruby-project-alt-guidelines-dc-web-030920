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

    def main_menu
        welcome_user 
        #selecting number option from menu 
        menu_selection = input_text
            if menu_selection == "1"
                # all the methods to let someone book a car
                # make_reservation(user)
            elsif menu_selection == "2"
                 self.user.display_reservations
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