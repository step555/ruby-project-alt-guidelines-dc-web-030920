
#creates a new user and saves it to the database.. requires the new username to be unique 
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

# #runs login info... finds the user and returns to the main menu or prompts them to create an account 
# def login
#     puts "Please login with your username:" #password later
#     input = not_yes_or_no
#     user = User.find_by(username:input)
#         if user 
#             main_menu(user)
#         else 
#             puts "No user found, would you like to create an account? 'Y' or 'N'"
#             answer = user_input
#             if answer.upcase == "Y"
#                 new_user
#             elsif answer.upcase == "N"
#                 goodbye
#             end
#         end
# end

