# def not_yes_or_no
#     gets.strip
# end

#user input is yes or no questions
# def user_input
#     input = gets.strip.upcase
#     if input == "N"
#         return input
#     elsif input == "Y"
#         return input
#     else
#         puts "Invalid entry, please try again."
#         user_input
#     end
# end

def car_input
    input = gets.strip.to_i
    if input < 1 || input >= Car.all.length
        puts "Invalid entry, please try again." 
        car_input
    else
        return input
    end
end


def date_input


end
