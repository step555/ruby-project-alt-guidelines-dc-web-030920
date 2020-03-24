

def new_user
    puts "Please enter a username:"
    user_name = user_input
    user_already_created = User.find_by(username: user_name)
        if user_already_created
            puts "I'm sorry, that username already exists"
            new_user
        else
            puts "Please enter your age:"
            i_age = user_input
            user = User.create(username: user_name, age: i_age)
            main_menu(user)
        end
end

def login
    puts "Please login with your username:" #password later
    input = user_input
    user = User.find_by(username:input)
        if user 
            main_menu(user)
        else 
            puts "No user found, would you like to create an account? 'Y' or 'N'"
            answer = user_input
            if answer.upcase == "Y"
                new_user
            elsif answer.upcase == "N"
                goodbye
            end
        end
end
    #prompt for username
        #user name exists then 
        #if username doesn't exist
            #invalid user. prompt create new user and age
             # figure out how to make usernames unique 
                #then create new user
                #if new user created then return to prompt for username
    

