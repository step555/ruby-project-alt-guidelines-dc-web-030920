class Cli
    attr_accessor :user 


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

    def input_text
        gets.strip
    end

    def goodbye
        puts "Goodbye!"
        car_image
        exit
    end

    # def new_user
    #     puts "Please enter a username:"
    #     user_name = not_yes_or_no
    #     user_already_created = User.find_by(username: user_name)
    #         if user_already_created
    #             puts "I'm sorry, that username already exists"
    #             new_user
    #         else
    #             puts "Please enter your age:"
    #             i_age = not_yes_or_no
    #             user = User.create(username: user_name, age: i_age)
    #             main_menu(user)
    #         end
    # end
    
    #runs login info... finds the user and returns to the main menu or prompts them to create an account 
    def login
        puts "Please login with your username:" #password later
        input = input_text
        user = User.find_by(username:input)
            if user 
                #an instance of user is saved to the cli instance
                self.user = user
            #     main_menu
            else 
                puts "No user found, would you like to create an account? 'Y' or 'N'"
                answer = input_yes_or_no
                if answer.upcase == "Y"
                    # new_user
                elsif answer.upcase == "N"
                    goodbye
                end
            end
    end
    

    def welcome
        car_image
        login
    end

    
end